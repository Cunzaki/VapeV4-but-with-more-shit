# AGENTS.md — VapeV4-but-with-more-shit

Guide for AI agents working in this repository. Primary focus: **reverse-engineering Roblox games** and extending **per-game Vape scripts** in `games/`.

---

## Project goals

1. **Maintain and extend a VapeV4 fork** — a Roblox exploit client with universal modules plus per-place game scripts.
2. **Reverse-engineer target games** using decompiled Lua in `decompiled games/`, document findings in `RE/`, and implement features in `games/*.lua`.
3. **Keep game integrations accurate** — hooks must match real game APIs (packets, weapon tables, team flags), not guesses.

Upstream credits: [7GrandDadPGN/VapeV4ForRoblox](https://github.com/7GrandDadPGN/VapeV4ForRoblox). This fork adds bullet tracers, desync, visualizers, improved NPC detection, and custom game support (notably **REDLINER** and **Futuretops**).

---

## Repository layout

| Path | Purpose |
|------|---------|
| `NewMainScript.lua` / `loader.lua` | Public loadstring entry; syncs repo to executor `writefile` area |
| `main.lua` | Loads GUI → `universal.lua` → `games/{PlaceId}.lua` → `vape:Load()` |
| `guis/` | GUI implementations (`new.lua` default). Defines `shared.vape`, module API, shared config profiles |
| `games/` | Per-place scripts (~44 `.lua`). **Primary edit target for game features** |
| `games/universal.lua` | Universal modules (~15k lines). Runs on every game |
| `libraries/` | Shared libs loaded by universal: `entity`, `esp`, `hash`, `prediction`, `vm`, `drawing` |
| `decompiled games/` | Decompiled Roblox game scripts (Potassium decompiler). **Source of truth for RE** |
| `RE/` | Human-written RE notes (`5411969757-vak-weapons.md`, add more as needed) |
| `assets/` | GUI asset references (mostly rbxassetid in guis) |

**Runtime cache** (not in repo): executor `newvape/` folder — `main.lua`, `games/`, `guis/`, `libraries/`, `profiles/` (`commit.txt`, `gui.txt`, saved configs).

---

## Bootstrap flow

```
loadstring(NewMainScript.lua)
  → loader.lua downloads/syncs files to newvape/
  → main.lua
      → guis/{gui}.lua  → shared.vape
      → games/universal.lua
      → games/{game.PlaceId}.lua  (or HTTP fallback)
      → vape:Load()
```

**Game routing**

- **Primary:** `game.PlaceId` → `games/{PlaceId}.lua`
- **Aliases:** thin routers set `vape.Place = <canonicalId>` and load the real script (e.g. Bedwars, Skywars)
- **Shared profiles:** `guis/new.lua` → `SHARED_GAME_CONFIGS` — REDLINER places share config under canon place `115875349872417`
- **Developer mode:** `shared.VapeDeveloper` uses local `readfile` instead of GitHub HTTP

**Required executor APIs** for full functionality: `writefile`/`readfile`/`isfile`, `hookfunction`/`restorefunction`, `debug` library, `getsenv`/`getconnections`/`getgc` (game-dependent).

---

## Game script patterns

All game scripts assume `shared.vape` exists and use:

```lua
local vape = shared.vape
local entitylib = vape.Libraries.entity
local run = function(func) func() end  -- or pcall wrapper
```

Common structure:

1. `cloneref` services
2. Helper functions (`isFriend`, team checks, notifications)
3. Multiple `run(function() ... end)` blocks registering modules via `vape.Categories.*:CreateModule`
4. Overrides of `entitylib.targetCheck`, `entitylib.getEntityColor`, etc.
5. Optional `return '<placeId>'` at end (legacy; `main.lua` ignores it)

**Module categories:** `Blatant`, `Render`, `Utility`, `Minigames`, `Friends`, `Main`, etc. (defined in GUI).

**Cleanup:** use `vape:Clean(connection)` for connections tied to script lifetime.

---

## Games in scope (current work)

### REDLINER (primary — decompiled on disk)

| Place ID | Role | Game script |
|----------|------|-------------|
| `94987506187454` | Main / lobby | `games/94987506187454.lua` |
| `115875349872417` | FFA | `games/115875349872417.lua` |
| `126691165749976` | Match | `games/126691165749976.lua` |

All three place files are **~4972-line duplicates** of the same logic. Canonical reference copy: `games/redliner_shared.lua` (not auto-loaded; edit place files or sync from shared).

**Decompiled sources**

| Folder | Contents |
|--------|----------|
| `decompiled games/Ugc_94987506187454/` | Main place — `ReplicatedStorage.Assets` tree, one player snapshot |
| `decompiled games/scripts_115875349872417/` | FFA place — same RS assets + `StarterPlayer` scripts |

Use `Ugc_94987506187454` as the canonical module tree; `scripts_115875349872417` for client bootstrap (`PlayerModule`, etc.).

#### REDLINER game overview

**Genre:** PvP combat — melee sword (`Redliner`) + four guns (`Castigate`, `Phoenix`, `Siege`, `Monarch`). Modes: Duels, Wingman, FFA, Tutorial, Training.

**Core architecture** (`ReplicatedStorage.Assets/`):

```
ModuleScripts/
├── chrono/          # Custom entity replication (v2.0.7) — NOT hit detection
├── Packets/         # Binary RPC layer (~70+ hashed packet types)
├── Attack/          # Hitbox combat queries
│   └── Hitbox       # Box/Sphere/Part/Cone vs CollectionService "Hurtbox" parts
├── ItemDef          # Weapon stat catalog
├── CEnum, ModesDef, QueueDef, PlaceContext, LevelService, ...
Shared/
├── Entity           # Chrono entity API (duplicate export path)
SharedClasses/
└── ItemRegistry     # melee: Redliner; gun: Castigate, Phoenix, Siege, Monarch
```

**Combat model**

- **Hurtboxes:** parts tagged `"Hurtbox"`; `Attack.Hitbox:cast()` uses `OverlapParams` with `FilterType = Include` on tagged parts.
- **Melee hits:** packet `_x2e2c62e0acfc88ae` → remote `_xe6cbd0bf2a4cf278`  
  `(itemId, action, ?, Vector3F24 origin, {hurtbox Instances}, metadata)`
- **Gun shots:** packet `_x77a8b8d28b943359` → remote `_xf3679e1e333be24e`  
  `(String, F32×4, Bool8, F32, Vector3F32, String, U32×2)`
- **Parry:** server-authoritative; client signals via animations + timing. Parry key: **F** (`Enum.KeyCode.F`).

**What's NOT in decompile** (need future dumps): `ServerStorage.Assets` weapon modules, `PacketPredicate`, server combat/parry handlers, `Assets.Animations` catalog.

#### Vape REDLINER modules (`games/redliner_shared.lua`)

Registered under `vape.Categories.Minigames`:

| Module | Mechanism |
|--------|-----------|
| **Auto Parry** | Animation watchers on enemies; gun draw/shot/melee anim IDs; proximity + aim dot; `VirtualInputManager` F key |
| **Auto Attack** | LMB via VIM when enemy in range; respects anti-parry |
| **Reach** | Hooks `Attack.castOnce/castMore/castContinuous`, `Attack.Hitbox.cast`, melee packet hurtbox list |
| **Kill Aura** | Sends melee packets at nearest enemy in range |
| **Draw Timer HUD** | Gun draw timing UI per weapon (Castigate/Phoenix/Siege/Monarch delays) |
| **Threat Indicator** | On-screen threat labels for melee/gun/glint |
| **Hitbox Visualizer** | Debug viz for swing cones, enemy hurtboxes, bullet rays |
| **Anim Logger** | Logs animation IDs for RE |

**Key integration points** (grep these when editing):

- `MELEE_PACKET_NAME`, `GUN_PACKET_NAME` — packet hashes
- `installMeleePacketHook`, `installAttackReachHook`, `installPacketMetatableHook`
- `bindParryScanLoop`, `startEnemyWatchers`, `bindCombatLoop`
- `GUN_DRAW_ANIM_IDS`, `GUN_SHOT_ANIM_IDS`, `PARRY_ANIM_IDS`
- `require(replicatedStorage.Assets.ModuleScripts.Packets)` for packet fire/listen

**Editing rule:** When changing REDLINER logic, update `redliner_shared.lua` **and** sync all three place files (`94987506187454`, `115875349872417`, `126691165749976`) or consolidate to a shared require pattern.

---

### Futuretops / VIP Server — place `5411969757`

| Item | Path |
|------|------|
| Game script | `games/5411969757.lua` (~926 lines) |
| RE doc | `RE/5411969757-vak-weapons.md` |
| Decompiled | **Not currently on disk** (indexed paths exist for `Ugc_5411969757`, `scripts_5411969757_457242` — restore if needed) |

**Game:** Military training shooter (AFK Studios). HUD: `FTHUD`. Gamemodes via `Lighting.CurrentGamemode` (TDM, CTF, KOTH, HP, 1V1, etc.).

**Dual weapon systems:**

1. **VAK (modern):** `PlayerGui.VAK_UI` → `ToolService`, `MediService`, `gunModule`; tools have `Client` ModuleScript returning weapon table (`RoF`, `Ammo`, `MaxAmmo`, `ReloadTime`, …).
2. **Legacy SMG:** `Tool.SMG.Gun` LocalScript with upvalues `u6` (inf ammo), `u13` (ammo), `u17` (fire gate), `u25.Reload`.

**Team logic:** `Team.isFFA` and `Team.isLobby` BoolValues control targeting. `canTargetPlayer()` in game script mirrors game rules.

**Vape modules:** `InfiniteAmmo`, `FireRate` (delay slider), `InstantReload` — hooks `wait`/`task.wait`, VAK services, legacy gun envs. CheatDetector flags: spectate-exploit, team-esp-bypass.

**Critical:** Never hook `Requirement.OnInvoke` — causes instant kick.

---

## Other game scripts (brief)

| File | Game | Notes |
|------|------|-------|
| `universal.lua` | All | Movement, ESP, tracers, server hop, whitelist, etc. |
| `5938036553.lua` | Frontlines | Uses `libraries/drawing.lua` actor |
| `606849621.lua` | — | Uses `libraries/vm.lua` bytecode tools |
| `155615604.lua` | Prison Life | Large standalone script |
| `14104248348.lua` | On Tap | GameId guard; several place routers forward here |
| `6872274481.lua` | Bedwars | Disabled (kick message) |
| `redliner_autofarm_standalone.lua` | REDLINER | Standalone, no Vape dependency |

Place routers (`vape.Place = ...`) are ~40-line stubs — edit the **canonical** target file, not every alias.

---

## Reverse-engineering methodology

Follow this when analyzing `decompiled games/`:

1. **Decompilation analysis** — Read decompiler output; verify behavior; replace wrong legacy comments.
2. **Improve readability** — Rename variables/functions in Ghidra/IDA-style DB if using external tools; in-repo, document in `RE/*.md`.
3. **Deep dive** — Use disassembly when decompilation is ambiguous; document low-level behavior.
4. **Never guess numeric conversions** — use MCP `int_convert` if available.
5. **Derive conclusions from evidence** — cite decompiled file paths and line behaviors.
6. **Document** — Add `RE/<placeId>-<topic>.md` for non-trivial findings.

**Decompiled file naming:** `{id}_{hash}_{OriginalName}.{Class}.lua` in `scripts_*` trees; UGC trees mirror live instance hierarchy.

**Key REDLINER files to read first:**

- `.../ModuleScripts/Attack/Hitbox.ModuleScript.lua`
- `.../ModuleScripts/Attack.ModuleScript.lua`
- `.../ModuleScripts/Packets.ModuleScript.lua`
- `.../ModuleScripts/chrono/Shared/Entity.ModuleScript.lua`
- `.../ModuleScripts/ItemDef.ModuleScript.lua`
- `.../ModuleScripts/CEnum.ModuleScript.lua`

---

## Code style (from CONTRIBUTING + repo conventions)

- Match surrounding code: naming, `run()` blocks, `cloneref`, `vape:Clean`, module option patterns.
- **Minimize scope** — smallest correct diff; don't refactor unrelated code.
- **No over-engineering** — inline simple logic; avoid extra abstractions for one-off helpers.
- **Comments** — only for non-obvious RE findings or hook rationale.
- **Tests** — only when requested; this project is executor/runtime tested.
- **Commits** — only when user explicitly asks.
- **No new markdown** unless requested (except `AGENTS.md` and `RE/` docs for RE work).

---

## Agent workflow checklist

When asked to add or fix a game feature:

1. Identify **place ID** and load matching `games/{id}.lua` (+ `redliner_shared.lua` if REDLINER).
2. Find relevant logic in `decompiled games/` — read actual module, don't assume from Vape script alone.
3. Trace **client → server** path (packets, remotes, `FireServer` args) before implementing hooks.
4. Register module under appropriate `vape.Categories.*` with `CreateModule` / sliders / toggles.
5. Use `entitylib` for targeting; respect friends/whitelist/team options.
6. Guard hooks with `pcall`, `checkcaller`, and idempotent install flags (`*Hooked` booleans).
7. Document non-obvious RE in `RE/` if the finding will be needed again.
8. For REDLINER, verify packet hashes still match `Packets.ModuleScript.lua` in decompile.

When asked for RE only:

1. Read `decompiled games/` first.
2. Cross-reference with existing `games/*.lua` hooks (they encode prior RE).
3. Output structured notes; propose `RE/*.md` updates.

---

## Quick reference — important globals

| Symbol | Role |
|--------|------|
| `shared.vape` | Main client API (modules, categories, notifications, save/load) |
| `vape.Libraries.entity` | Player/entity scan, targeting, colors |
| `vape.Categories.Minigames` | REDLINER + Futuretops custom modules |
| `vape.CheatDetector` | Anti-cheat scanner (Futuretops registers filters) |
| `whitelist` | Player whitelist (universal) |

---

## Known gaps / next decompile targets

**REDLINER**

- `ServerStorage.Assets` — `Redliner`, `Castigate`, `BaseGun`, weapon behavior
- `ServerStorage.Assets.Libraries.PacketPredicate`
- `ReplicatedStorage.Assets.Animations`
- ServerScriptService combat services

**Futuretops (`5411969757`)**

- Restore `decompiled games/Ugc_5411969757/` and `scripts_5411969757_457242/`
- Priority: `ToolService`, `MediService`, `gunModule`, `GamemodesController`, `Gun.LocalScript`

---

## Files agents edit most often

| Task | Files |
|------|-------|
| REDLINER combat features | `games/redliner_shared.lua`, `games/94987506187454.lua`, `games/115875349872417.lua`, `games/126691165749976.lua` |
| Futuretops weapons | `games/5411969757.lua`, `RE/5411969757-vak-weapons.md` |
| Universal movement/ESP | `games/universal.lua` |
| Shared config profiles | `guis/new.lua` (`SHARED_GAME_CONFIGS`) |
| Entity/ESP behavior | `libraries/entity.lua`, `libraries/esp.lua` |
| RE documentation | `RE/*.md` |
