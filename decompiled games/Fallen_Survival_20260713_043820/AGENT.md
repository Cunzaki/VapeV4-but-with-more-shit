# Fallen Survival — Agent Guide

> **Dump:** `decompiled games/Fallen_Survival_20260713_043820`  
> **Merged from:** Medium Server ×2 + Large Server (3 `.rbxlx` Volt workspace saves)  
> **Vape integration:** `libraries/fallen_bypass.lua`, `games/fallen_survival.lua`, place IDs `16849012343` / `13800717766`

---

## What is Fallen Survival?

**Fallen Survival** is a Roblox survival/crafting PvP game with:

- Base building (`Bases`, benches, electricity, storage)
- Gun combat with **viewmodels** (`ReplicatedStorage.VMs`, `workspace.VFX.VMs`)
- Crafting / research / armor systems
- Vehicles (boats, flycopters), animals, world events
- Heavy **client-side anticheat** embedded in `ReplicatedStorage.Modules.AssetContainer`

Players spawn into **private server instances** with different place IDs:

| Place ID | Server type |
|----------|-------------|
| `16849012343` | Medium Server |
| `13800717766` | Large Server |

Detection fallback: if `ReplicatedStorage.Modules.AssetContainer` exists, treat as Fallen even on unknown place IDs.

---

## Dump layout

```
Fallen_Survival_20260713_043820/
├── AGENT.md                    ← this file
├── manifest/
│   ├── merge_report.txt        ← merge stats
│   ├── merge_report.json       ← per-script merge details
│   ├── module_source_map.txt   ← path → file → sha256
│   ├── remotes.txt             ← RemoteEvent/Function inventory
│   └── instances_summary.txt   ← class counts
├── scripts_client/             ← StarterPlayer / StarterGui
├── scripts_shared/             ← ReplicatedStorage / ReplicatedFirst
├── scripts_recovered/          ← Workspace + misc
├── scripts_server/             ← server scripts (mostly FE placeholders)
└── reference/
    ├── bypas.txt               ← GC ban-table bypass (original)
    ├── source.lua              ← Iridescent reference cheat
    └── insulin.lua             ← Insulin reference cheat
```

### Merge results

- **132** unique script paths after deduplication
- **82** unique source hashes
- **1** hash conflict (largest variant kept)
- Large server dump had **4 extra scripts** vs medium copies

---

## Game architecture (from dump)

### Core services tree

| Root | Role |
|------|------|
| `ReplicatedStorage.Modules` | Shared modules — **AssetContainer is the anticheat + asset loader** |
| `ReplicatedStorage.CharacterScripts` | Per-character client controllers (equip, inventory, viewmodel, state) |
| `ReplicatedStorage.Values` | Game state values |
| `ReplicatedStorage.VFX` / `VMs` | Weapon viewmodels & effects |
| `ReplicatedStorage.Benches` | Crafting bench models + server scripts |
| `ReplicatedStorage.SettingRemotes` | `Fetch` / `Update` / `Reset` / `Teleport` |
| `workspace` | Map, bases, animals, vehicles, lobby |

### Important client controllers

| Script | Purpose |
|--------|---------|
| `CharacterScripts.ViewmodelController` | First-person weapon VM |
| `CharacterScripts.EquipController` | Equip / gun handling |
| `CharacterScripts.StateController` | Movement / state machine |
| `CharacterScripts.InventoryController` | Inventory UI + data |
| `CharacterScripts.CameraController` | Camera behavior |
| `Modules.RaycastUtil` | Hit detection raycasts (players, animals, parts) |
| `Modules.ToolInfo` | Weapon stats / damage tables |
| `Modules.AssetContainer` | **Anticheat** — obfuscated, decompile timeout in dump |

### Combat / raycast notes

`RaycastUtil` filters hits on:

- `HumanoidRootPart` / `CollisionPart` on humanoid models
- Transparent / non-colliding parts
- `Animals` and `Events` folders (NPC/world entities)
- Vehicles (`VehicleFake` collision group)

**Implication for Vape:** universal silent aim + entitylib should work on players; fake-entity scan picks up `Animals`/`Events` humanoids. Viewmodels live under `workspace.VFX.VMs` — exclude from wall/tracer raycasts.

### Remotes (readable subset)

```
ReplicatedStorage.SettingRemotes.Fetch      (RemoteFunction)
ReplicatedStorage.SettingRemotes.Update     (RemoteEvent)
ReplicatedStorage.SettingRemotes.Reset      (RemoteFunction)
ReplicatedStorage.SoundRemotes.Play         (RemoteEvent)
ReplicatedStorage.Sound                     (RemoteFunction)
```

Most anticheat remotes use **obfuscated names** (binary garbage strings) — see `manifest/remotes.txt`.

---

## Anticheat & bypass

### When to run bypass

| Timing | Required? |
|--------|-----------|
| **Before any cheat GUI / universal modules** | **YES** — Vape runs `fallen_bypass.lua` in `main.lua` first |
| **After AssetContainer is required** | **YES** — `StateAssetController` calls `require(AssetContainer)()` ~line 58; ban tables do not exist in `getgc` before this |
| **After `ReplicatedStorage.Remotes` exists** | YES |
| **After character controllers clone** (`InventoryController` / `StateController` on character) | Recommended readiness signal |
| **On every respawn** | YES — re-neutralize character ban tables |

**Common failure:** `Failed to load. 0x01` when bypass runs too early (before AssetContainer init). Fixed in v2 bypass with `waitForAnticheatInit()` + retry loops.

### Offset dumper (run when AC updates / bypass fails)

**Do not inject Vape first** — bypass kicks on failure. Join Fallen, spawn in, then run:

```lua
loadstring(readfile("tools/fallen_anticheat_offset_dumper.lua"), "fallen_ac_dumper")()
```

Polls `getgc` for 30 seconds and writes to `fallen_ac_dumps/<PlaceId>_<timestamp>/`:

| File | Contents |
|------|----------|
| `offsets.txt` | Human-readable report + recommended indices |
| `offsets.json` | Full scan data |
| `bypass_offsets.lua` | Ready-to-paste offset table for `fallen_bypass.lua` |

Optional: `getgenv().FallenDumperPollSeconds = 45`

Quick probe (single snapshot): `tools/fallen_gc_probe.lua`

### Bypass stages (implemented in `libraries/fallen_bypass.lua`)

#### Stage 1 — Remotes ban table (`0x01`)

Scans `getgc(true)` for a table where `[1]` is a `Remotes` Instance folder.  
Neutralizes `[4]` (ban table) with empty `__index` / `__newindex` metatable.

#### Stage 2 — Character ban tables (`0x02`)

Finds 9-length table: `{Character, Humanoid, ...}`.  
Neutralizes slots `[8]` and `[5]`; clears `[5]`.

#### Stage 3 — Recursive self-table hook (`0x03`)

Finds self-referential GC tables and hooks `__newindex` to block new ban subtables unless whitelisted.

#### Stage 4 — AssetContainer proto hooks (from `source.lua` + `insulin.lua`)

Hooks decompiled protos inside functions whose `short_src` contains `AssetContainer`:

| Detection | Hook action |
|-----------|-------------|
| `SurfaceGui` constant | Block (ESP highlight detection) |
| `Foundation` constant | Block (xray / touch collision) |
| `LocalAmmo` + `Equipped` | Block (viewmodel attribute scan) |
| `WalkSpeed` constant | Block (speed detection) |
| 23 constants | Strip nested tables from arg before calling original |
| 9 constants + 3 upvalues | Block (attribute detection) |
| Other suspicious calls | Block empty strings, zero-arg, function args |

**Kick codes:** `Failed to load. 0x01` / `0x02` / `0x03` — bypass failed, rejoin after spawn.

### Reference scripts (`reference/`)

| File | What it is |
|------|------------|
| `bypas.txt` | Minimal standalone GC bypass (stages 1–3 only) |
| `source.lua` | Iridescent — full GUI cheat; bypass + AssetContainer constant hooks |
| `insulin.lua` | Insulin — AssetContainer proto hook suite + full feature set |

Use these as **RE reference only** — Vape does not load them at runtime.

---

## Vape integration plan

### Load order (`main.lua`)

```
1. GUI init (vape object)
2. isFallenSurvival() ?
   └─ yes → libraries/fallen_bypass.lua  (ALWAYS FIRST)
3. games/universal.lua                  (all standard modules)
4. games/<PlaceId>.lua                  (fallen_survival hooks)
5. vape:Load()
```

### Files added

| File | Role |
|------|------|
| `libraries/fallen_bypass.lua` | Always-on anticheat bypass |
| `games/fallen_survival.lua` | Fallen-specific entity/VFX hooks |
| `games/16849012343.lua` | Medium server loader |
| `games/13800717766.lua` | Large server loader |

### What works from universal (out of the box)

- **Combat:** Silent Aim, Triggerbot, AutoFire, Hit Sounds, Bullet Tracers, Target Highlight
- **Movement:** Speed, Fly, Long Jump, No Fall (bypass blocks WalkSpeed AC reports)
- **Visuals:** ESP, Chams, NameTags, Full Bright (Foundation/SurfaceGui AC blocked)
- **Utility:** Auto Reconnect, FPS boost, etc.

### Fallen-specific `fallen_survival.lua` hooks

- Re-registers entities after respawn
- Watches `Animals`, `Events`, `Bases` for NPC fake entities
- Adds `workspace.VFX.VMs` children to visualizer ignore list (prevents VM raycast false positives)

### Future Fallen-only features (not yet implemented)

Priority order for next development:

1. **Gun info integration** — read `Modules.ToolInfo` for range/fire rate (better autofire)
2. **Crafting / auto-farm** — `RecipeModule`, bench controllers
3. **Base ESP** — `workspace.Bases` descendant scan
4. **No spread / recoil** — hook `ViewmodelController` / shoot remotes (needs live RE)
5. **Silent step / flight restriction bypass** — reference `source.lua` flags

---

## RE workflow for agents

1. **Search dump first:** `manifest/module_source_map.txt` → find path → open matching `.lua`
2. **Cross-reference remotes:** `manifest/remotes.txt`
3. **AssetContainer is obfuscated** — use runtime `getgc` + `getconstants` on live client, not static dump
4. **Compare reference cheats** — `reference/source.lua` / `insulin.lua` for working hook patterns
5. **Test on Medium (`16849012343`) and Large (`13800717766`)** — large server has extra scripts

### Regenerating the dump

```powershell
python tools/fallen_rbxlx_merger.py
```

Clears `decompiled games/` and merges the three Volt workspace `.rbxlx` files configured in the script.

---

## Executor requirements

Fallen bypass **requires**:

- `cloneref`, `getgc`, `hookfunction` (or `replaceclosure`)
- `getinfo` / `debug.getinfo`
- `getprotos`, `getproto`, `getconstants`, `getupvalues`
- `setrawmetatable`, `getrawmetatable`, `rawget`, `rawset`, `rawlen`, `rawequal`
- `islclosure`, `isexecutorclosure` (recommended)

Without these, bypass warns and aborts — Vape will still load but detections may trigger.

---

## Quick checklist before testing

- [ ] Spawned in with a character (not menu / loading screen)
- [ ] Bypass runs before universal (check `getgenv().FallenBypassLoaded`)
- [ ] No kick `0x01`–`0x03` on inject
- [ ] Silent aim hits players; try `Target.Walls` on/off
- [ ] ESP/chams don't instant-ban (AssetContainer hooks active)
- [ ] Speed/fly don't kick (WalkSpeed proto hook active)
- [ ] Rejoin after death — bypass re-runs on `CharacterAdded`
