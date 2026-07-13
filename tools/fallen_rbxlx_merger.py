#!/usr/bin/env python3
"""
Merge multiple Fallen Survival .rbxlx place dumps into one deduplicated RE tree.
Extracts ModuleScript / LocalScript / Script sources, remotes, and instance manifests.
"""

from __future__ import annotations

import hashlib
import json
import re
import shutil
import sys
from collections import defaultdict
from datetime import datetime
from pathlib import Path

SCRIPT_CLASSES = {"ModuleScript", "LocalScript", "Script"}
REMOTE_CLASSES = {
    "RemoteEvent",
    "RemoteFunction",
    "UnreliableRemoteEvent",
    "BindableEvent",
    "BindableFunction",
}
INTERESTING_CLASSES = SCRIPT_CLASSES | REMOTE_CLASSES | {
    "Folder",
    "Model",
    "StringValue",
    "BoolValue",
    "NumberValue",
    "ObjectValue",
}

INVALID_CHARS = re.compile(r'[<>:"/\\|?*\x00-\x1f]')
ROOT = Path(__file__).resolve().parents[1]
DECOMPILED_ROOT = ROOT / "decompiled games"
OUTPUT_NAME = f"Fallen_Survival_{datetime.now().strftime('%Y%m%d_%H%M%S')}"

SOURCE_FILES = [
    Path(r"c:\Users\Cunza\AppData\Local\Volt\workspace\place 16849012343 Fallen Survival Medium Server.rbxlx"),
    Path(r"c:\Users\Cunza\AppData\Local\Volt\workspace\place 16849012343 Fallen Survival Medium Server(1).rbxlx"),
    Path(r"c:\Users\Cunza\AppData\Local\Volt\workspace\place 13800717766 Fallen Survival Large Server(1).rbxlx"),
]


def sanitize(name: str, fallback: str = "Unnamed") -> str:
    if not name:
        return fallback
    name = INVALID_CHARS.sub("_", name.strip())
    name = name.rstrip(" .")
    if not name:
        return fallback
    if name.upper() in {
        "CON", "PRN", "AUX", "NUL",
        *{f"COM{i}" for i in range(1, 10)},
        *{f"LPT{i}" for i in range(1, 10)},
    }:
        name += "_"
    return name[:180]


def text_of(_elem) -> str:
    return ""


def classify_bucket(path: str) -> str:
    lowered = path.lower()
    if any(x in lowered for x in ("starterplayer", "startergui", "playerscripts", "playergui")):
        return "scripts_client"
    if any(x in lowered for x in ("replicatedstorage", "replicatedfirst")):
        return "scripts_shared"
    if any(x in lowered for x in ("serverscriptservice", "serverstorage", "serverscripts")):
        return "scripts_server"
    return "scripts_recovered"


def strip_invalid_xml(text: str) -> str:
    # XML 1.0 disallows most control chars outside whitespace.
    return "".join(
        ch for ch in text
        if ch in "\t\n\r" or (0x20 <= ord(ch) <= 0xD7FF) or (0xE000 <= ord(ch) <= 0xFFFD)
    )


def extract_cdata(prop: str, block: str) -> str:
    pattern = rf'<{prop}[^>]*><!\[CDATA\[(.*?)\]\]></{prop}>'
    match = re.search(pattern, block, re.DOTALL)
    return match.group(1) if match else ""


def iter_items(content: str):
    token_re = re.compile(r"<Item class=\"([^\"]+)\"[^>]*>|</Item>")
    stack: list[dict] = []
    pos = 0
    for match in token_re.finditer(content):
        token = match.group(0)
        if token.startswith("</Item"):
            if not stack:
                continue
            node = stack.pop()
            names = [n["name"] for n in stack if n.get("name")]
            names.append(node["name"] or node["class"])
            full_path = ".".join(sanitize(n, n) for n in names)
            yield {
                "path": full_path,
                "class": node["class"],
                "name": node["name"] or node["class"],
                "source": node.get("source"),
                "disabled": node.get("disabled", False),
            }
            continue

        cls = match.group(1)
        start = match.end()
        depth = 1
        scan = start
        while scan < len(content) and depth > 0:
            next_open = content.find('<Item class="', scan)
            next_close = content.find("</Item>", scan)
            if next_close == -1:
                break
            if next_open != -1 and next_open < next_close:
                depth += 1
                scan = next_open + 1
            else:
                depth -= 1
                scan = next_close + len("</Item>")

        block = content[start:scan - len("</Item>")] if depth == 0 else content[start:start + 50000]
        name = extract_cdata("string", block)
        if 'name="Name"' in block:
            name_match = re.search(r'<string name="Name"><!\[CDATA\[(.*?)\]\]></string>', block, re.DOTALL)
            if name_match:
                name = name_match.group(1)
        source = ""
        if 'name="Source"' in block:
            source_match = re.search(
                r'<ProtectedString name="Source"><!\[CDATA\[(.*?)\]\]></ProtectedString>',
                block,
                re.DOTALL,
            )
            if source_match:
                source = source_match.group(1)
        disabled = bool(re.search(r'<bool name="Disabled">true</bool>', block))
        stack.append({
            "class": cls,
            "name": name or cls,
            "source": source or None,
            "disabled": disabled,
        })


def parse_rbxlx(path: Path) -> dict:
    print(f"[parse] {path.name}")
    raw = path.read_text(encoding="utf-8", errors="replace")
    content = strip_invalid_xml(raw)
    scripts: dict[str, dict] = {}
    remotes: list[dict] = []
    instances: list[dict] = []
    source_place = path.name

    for node in iter_items(content):
        cls = node["class"]
        full_path = node["path"]

        if cls in INTERESTING_CLASSES:
            instances.append({
                "path": full_path,
                "class": cls,
                "source_place": source_place,
            })

        if cls in REMOTE_CLASSES:
            remotes.append({
                "class": cls,
                "path": full_path,
                "name": node["name"],
                "source_place": source_place,
            })

        if cls in SCRIPT_CLASSES and node.get("source"):
            key = f"{full_path}::{cls}"
            source = node["source"]
            scripts[key] = {
                "path": full_path,
                "class": cls,
                "name": node["name"],
                "source": source,
                "disabled": node["disabled"],
                "source_place": source_place,
                "hash": hashlib.sha256(source.encode("utf-8", "replace")).hexdigest(),
                "lines": source.count("\n") + 1,
                "bytes": len(source.encode("utf-8", "replace")),
            }

    return {
        "place_file": path.name,
        "scripts": scripts,
        "remotes": remotes,
        "instances": instances,
    }


def merge_dumps(dumps: list[dict]) -> tuple[dict, dict]:
    merged_scripts: dict[str, dict] = {}
    merge_report = {
        "sources": [],
        "unique_by_hash": {},
        "conflicts": [],
        "only_in": defaultdict(list),
    }

    all_keys = set()
    for dump in dumps:
        all_keys.update(dump["scripts"].keys())

    for key in sorted(all_keys):
        variants = []
        for dump in dumps:
            if key in dump["scripts"]:
                variants.append(dump["scripts"][key])

        if not variants:
            continue

        chosen = max(variants, key=lambda v: (v["bytes"], v["lines"]))
        merged_scripts[key] = chosen

        places = sorted({v["source_place"] for v in variants})
        for dump in dumps:
            if key not in dump["scripts"]:
                merge_report["only_in"][dump["place_file"]].append(key)

        hashes = {v["hash"] for v in variants}
        if len(hashes) > 1:
            merge_report["conflicts"].append({
                "key": key,
                "variants": [
                    {
                        "place": v["source_place"],
                        "hash": v["hash"][:12],
                        "bytes": v["bytes"],
                    }
                    for v in variants
                ],
                "chosen_from": chosen["source_place"],
            })

        merge_report["sources"].append({
            "path": chosen["path"],
            "class": chosen["class"],
            "places": places,
            "hash": chosen["hash"],
            "bytes": chosen["bytes"],
            "lines": chosen["lines"],
        })

        merge_report["unique_by_hash"].setdefault(chosen["hash"], chosen["path"])

    return merged_scripts, merge_report


def write_script_tree(out_dir: Path, merged_scripts: dict[str, dict]) -> None:
    used_paths: dict[str, int] = {}
    module_map: list[str] = []

    for key, script in sorted(merged_scripts.items(), key=lambda kv: kv[1]["path"].lower()):
        bucket = classify_bucket(script["path"])
        rel = "/".join(sanitize(part, part) for part in script["path"].split("."))
        base = f"{rel}.{script['class']}.lua"
        target = out_dir / bucket / base
        if target.exists():
            used_paths[base] = used_paths.get(base, 0) + 1
            stem = target.stem
            target = target.with_name(f"{stem}_{used_paths[base]}{target.suffix}")

        target.parent.mkdir(parents=True, exist_ok=True)
        header = (
            f"-- Path: {script['path']}\n"
            f"-- Class: {script['class']}\n"
            f"-- Source dump: {script['source_place']}\n"
            f"-- SHA256: {script['hash']}\n\n"
        )
        target.write_text(header + script["source"], encoding="utf-8", newline="\n")
        module_map.append(f"{script['path']}\t{script['class']}\t{bucket}/{target.name}\t{script['hash']}")

    (out_dir / "manifest").mkdir(parents=True, exist_ok=True)
    (out_dir / "manifest" / "module_source_map.txt").write_text(
        "# path\tclass\tfile\thash\n" + "\n".join(module_map),
        encoding="utf-8",
        newline="\n",
    )


def write_remotes(out_dir: Path, dumps: list[dict]) -> None:
    seen = set()
    lines = ["# Remote inventory (merged, deduplicated by path)", ""]
    for dump in dumps:
        for remote in dump["remotes"]:
            ident = (remote["class"], remote["path"])
            if ident in seen:
                continue
            seen.add(ident)
            readable = remote["name"]
            if any(ord(c) < 32 or ord(c) > 126 for c in readable):
                readable = f"<obfuscated:{hashlib.md5(readable.encode('utf-8', 'replace')).hexdigest()[:8]}>"
            lines.append(f"{remote['class']}\t{remote['path']}\tname={readable}\tfrom={remote['source_place']}")
    (out_dir / "manifest").mkdir(parents=True, exist_ok=True)
    (out_dir / "manifest" / "remotes.txt").write_text("\n".join(lines), encoding="utf-8", newline="\n")


def write_instance_summary(out_dir: Path, dumps: list[dict]) -> None:
    counts: dict[str, int] = defaultdict(int)
    top_paths: dict[str, set[str]] = defaultdict(set)
    for dump in dumps:
        for inst in dump["instances"]:
            counts[inst["class"]] += 1
            parts = inst["path"].split(".")
            if parts:
                top_paths[parts[0]].add(inst["path"])

    lines = ["# Instance summary (merged)", ""]
    for cls, count in sorted(counts.items(), key=lambda kv: (-kv[1], kv[0])):
        lines.append(f"{cls}\t{count}")

    lines.extend(["", "# Top-level services / roots", ""])
    for root in sorted(top_paths):
        lines.append(f"{root}\t{len(top_paths[root])} paths")

    (out_dir / "manifest").mkdir(parents=True, exist_ok=True)
    (out_dir / "manifest" / "instances_summary.txt").write_text(
        "\n".join(lines), encoding="utf-8", newline="\n",
    )


def copy_reference_scripts(out_dir: Path) -> None:
    ref_dir = out_dir / "reference"
    ref_dir.mkdir(parents=True, exist_ok=True)
    mapping = {
        "bypas.txt": Path(r"c:\Users\Cunza\Downloads\bypas.txt"),
        "source.lua": Path(r"c:\Users\Cunza\Downloads\source.lua"),
        "insulin.lua": Path(r"c:\Users\Cunza\Downloads\insulin.lua"),
    }
    for name, src in mapping.items():
        if src.exists():
            shutil.copy2(src, ref_dir / name)


def clear_decompiled_root() -> None:
    if DECOMPILED_ROOT.exists():
        shutil.rmtree(DECOMPILED_ROOT)
    DECOMPILED_ROOT.mkdir(parents=True, exist_ok=True)


def main() -> int:
    for src in SOURCE_FILES:
        if not src.exists():
            print(f"Missing source file: {src}", file=sys.stderr)
            return 1

    clear_decompiled_root()
    out_dir = DECOMPILED_ROOT / OUTPUT_NAME
    out_dir.mkdir(parents=True, exist_ok=True)

    dumps = [parse_rbxlx(path) for path in SOURCE_FILES]
    merged_scripts, merge_report = merge_dumps(dumps)

    write_script_tree(out_dir, merged_scripts)
    write_remotes(out_dir, dumps)
    write_instance_summary(out_dir, dumps)
    copy_reference_scripts(out_dir)

    (out_dir / "manifest" / "merge_report.json").write_text(
        json.dumps(merge_report, indent=2),
        encoding="utf-8",
    )
    (out_dir / "manifest" / "merge_report.txt").write_text(
        "\n".join([
            f"Merged Fallen Survival dump",
            f"Generated: {datetime.now().isoformat()}",
            f"Source files: {len(SOURCE_FILES)}",
            f"Unique scripts: {len(merged_scripts)}",
            f"Hash conflicts resolved: {len(merge_report['conflicts'])}",
            f"Unique content hashes: {len(merge_report['unique_by_hash'])}",
            "",
            "Per-file script counts:",
            *[f"  {d['place_file']}: {len(d['scripts'])}" for d in dumps],
        ]),
        encoding="utf-8",
        newline="\n",
    )

    print(f"[done] {out_dir}")
    print(f"  scripts: {len(merged_scripts)}")
    print(f"  conflicts: {len(merge_report['conflicts'])}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
