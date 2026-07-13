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


| Place ID      | Server type   |
| ------------- | ------------- |
| `16849012343` | Medium Server |
| `13800717766` | Large Server  |


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
    ├── fishy_bypass.txt          ← V3/fishy recursive hook (current bypass)
    ├── fallen_ultimate_v3.lua    ← Full V3 cheat reference
    ├── bypas.txt               ← Legacy GC ban-table bypass (outdated)
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


| Root                                 | Role                                                                      |
| ------------------------------------ | ------------------------------------------------------------------------- |
| `ReplicatedStorage.Modules`          | ~~Shared modules — **AssetContainer is the anticheat + asset loader~~**   |
| `ReplicatedStorage.CharacterScripts` | ~~Per-character client controllers (equip, inventory, viewmodel, state)~~ |
| `ReplicatedStorage.Values`           | ~~Game state values~~                                                     |
| `ReplicatedStorage.VFX` ~~/~~ `VMs`  | ~~Weapon viewmodels & effects~~                                           |
| `ReplicatedStorage.Benches`          | Crafting bench models + server scripts                                    |
| `ReplicatedStorage.SettingRemotes`   | `Fetch` / `Update` / `Reset` / `Teleport`                                 |
| `workspace`                          | Map, bases, animals, vehicles, lobby                                      |




### Important client controllers


| Script                                 | Purpose                                               |
| -------------------------------------- | ----------------------------------------------------- |
| `CharacterScripts.ViewmodelController` | First-person weapon VM                                |
| `CharacterScripts.EquipController`     | Equip / gun handling                                  |
| `CharacterScripts.StateController`     | Movement / state machine                              |
| `CharacterScripts.InventoryController` | Inventory UI + data                                   |
| `CharacterScripts.CameraController`    | Camera behavior                                       |
| `Modules.RaycastUtil`                  | Hit detection raycasts (players, animals, parts)      |
| `Modules.ToolInfo`                     | Weapon stats / damage tables                          |
| `Modules.AssetContainer`               | **Anticheat** — obfuscated, decompile timeout in dump |




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



### Current bypass (V3 / fishy — `libraries/fallen_bypass.lua`)

**Fallen Ultimate V3** and `reference/fishy_bypass.txt` use **only** the recursive self-table hook. They do **not** use the legacy `0x01` / `0x02` Remotes/Character ban-table neutralization from `reference/bypas.txt`. Running the old stages on current Fallen AC causes Vape to self-kick with `Failed to load. 0x01` / `0x02`.

#### How the recursive hook works

1. Wait for `LocalPlayer`, `game:IsLoaded()`, then character with `HumanoidRootPart`, `Humanoid`, and `Head` (or `UpperTorso`).
2. Scan `getgc(true)` for tables that:
  - Have no existing metatable
  - Contain a numeric key `1` (`found_index`)
  - Contain a self-reference (`rawequal(value, tbl)`)
  - Have `rawget(tbl, found_index) == nil`
3. On matching tables, install `__newindex` on the **inner** recursive table that blocks new ban subtables unless whitelisted:
  - Numeric pair tables `{ {n}, m }` where both are numbers
  - `{ [1] = 2 }` or 4-length tables with `[4] = false`
  - `{ [1] = string, [2] = 7 }`
4. Allowed writes pass through via `rawset`; blocked writes are silently dropped.

**Kick message (Fallen only):** `[Vape] Anticheat bypass failed — rejoin when fully loaded.` (V3 uses `[fishy.solutions] run when fully loaded!`)

**Non-Fallen games:** bypass still loads and scans quietly; no kick if tables are not found.

### When to run bypass


| Timing                                      | Required?                                                       |
| ------------------------------------------- | --------------------------------------------------------------- |
| **Before universal modules**                | **YES** — `main.lua` runs `fallen_bypass.lua` in **every** game |
| **After LocalPlayer + game loaded**         | YES — bypass waits up to 120s                                   |
| **After character + HRP + Humanoid + Head** | YES on Fallen (kick if timeout)                                 |
| **After AssetContainer init**               | Recommended — ban tables appear in `getgc` after AC loads       |
| **On every respawn**                        | YES — `CharacterAdded` re-runs scan (20s retry)                 |




### Vape integration



#### Load order (`main.lua`)

```
1. GUI init (vape object)
2. libraries/fallen_bypass.lua     (EVERY game, async bootstrap)
3. games/universal.lua             (includes always-on Anticheat Bypass module)
4. games/<PlaceId>.lua             (fallen_survival hooks on Fallen IDs)
5. vape:Load()
```



#### Files


| File                                        | Role                                                                  |
| ------------------------------------------- | --------------------------------------------------------------------- |
| `libraries/fallen_bypass.lua`               | V3/fishy recursive GC hook; publishes `vape.Libraries.fallenBypass`   |
| `games/universal.lua`                       | **Anticheat Bypass** Utility module (always on, cannot stay disabled) |
| `games/fallen_survival.lua`                 | Entity refresh, Animals/Events/Bases fake scan, VFX VM ignores        |
| `games/16849012343.lua` / `13800717766.lua` | Thin Fallen loaders                                                   |




#### Module status (`Utility → Anticheat Bypass`)


| ExtraText               | Meaning                                    |
| ----------------------- | ------------------------------------------ |
| `Loading`               | Bypass library not published yet           |
| `Idle`                  | Not Fallen Survival (no AssetContainer)    |
| `Waiting`               | Fallen, scan not hooked yet                |
| `Active` / `Active (N)` | Recursive hook installed (N = table count) |
| `Error`                 | Last scan error in `LastError`             |


Status API: `shared.vape.Libraries.fallenBypass` — fields `Active`, `IsFallen`, `HookCount`, `Run`, `LastError`.

### Offset dumper (optional — only if recursive hook stops working)

```lua
loadstring(readfile("tools/fallen_anticheat_offset_dumper.lua"), "fallen_ac_dumper")()
```

Writes `fallen_ac_dumps/<PlaceId>_<timestamp>/offsets.txt`, `.json`, `bypass_offsets.lua`.

### Reference scripts (`reference/`)


| File                     | What it is                                                                    |
| ------------------------ | ----------------------------------------------------------------------------- |
| `fishy_bypass.txt`       | **Current** — standalone V3/fishy recursive hook (from Fallen Ultimate V3)    |
| `fallen_ultimate_v3.lua` | Full Fallen Ultimate V3 cheat — bypass + silent aim + manipulation + gun mods |
| `bypas.txt`              | **Legacy** — stages 0x01/0x02/0x03 ban-table bypass (outdated for current AC) |
| `source.lua`             | Iridescent — AssetContainer proto constant hooks + full GUI                   |
| `insulin.lua`            | Insulin — AssetContainer proto hook suite                                     |


Use as **RE reference only** — Vape loads `fallen_bypass.lua` at runtime, not these files.

---



## Silent aim & combat (Fallen Ultimate V3 vs Vape universal)



### Fallen Ultimate V3 approach (game-native)

V3 does **not** hook `workspace:Raycast` for shooting. It integrates with Fallen's viewmodel stack:

#### 1. VMNetworkPointer discovery (~line 7488)

Scans `RunService.Heartbeat` connections whose function source contains `ViewmodelController`, walks upvalues to find a function whose source contains `AssetContainer`. Stored as `Cheat.Globals.VMNetworkPointer` — used for reload, auto-build, and other obfuscated remote fires.

#### 2. Targeting loop (~line 6785, Heartbeat)

- Maintains `Targeting.Targets` for players, military AI (`Soldier`, bosses), BTR
- Raycast blacklist: `Camera`, local character, `workspace.VFX`, invis walls
- Picks closest on-screen part within FOV (`flags.FovSize`)
- **Manipulation:** if target not visible, offsets local `Head` CFrame through `manipOffsets` ring (±3–8 studs, vertical peaks) via `FindVisiblePosition` until `IsPartVisible` succeeds
- **HitScan:** tests 20 corner vectors on target part scaled ×4; finds alternate visible impact point
- Exposes `Targeting.TargetPart`, `ManipulatedPosition`, `ScannedPosition`



#### 3. Fire remote hook (~line 8608)

When `ViewmodelController` fires, hooks `fire_remote_func` from `MissFunction` upvalue. On matching hash `v1`:

- Rewrites args `[3]` camera CFrame, `[5]` character root, `[8]` target position
- Uses `ManipulatedPosition` for origin when manipulation active
- Applies bullet drop prediction via `ToolInfo` + `ItemsModule` ammo stats
- Optional `HitScan` defers `HitFunction` with `ScannedPosition`



#### 4. Gun mods (~line 6740)

Hooks return table in `ViewmodelController` traceback — sets `FireRateMult`, `SpeedMult` (Instant Bullet), `RecoilMult`, spread/sway mults.

**Note:** V3 UI warns *"Instant bullet is needed… Without you may miss shots with silent aim and manipulation."*

### Vape universal approach (cross-game)


| Module                    | Mechanism                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------- |
| **Silent Aim**            | Hooks `Raycast`, `Ray.new`, `FindPartOnRay` — redirects ray toward `entitylib` target |
| **Triggerbot / AutoFire** | Mouse / tool activation + entity overlap                                              |
| **Target**                | `entitylib` player + fake entity scan                                                 |


**On Fallen:** `fallen_survival.lua` adds:

- `workspace.VFX.VMs` to `visualizerModels` ignore (prevents VM false wall blocks)
- `Animals` / `Events` / `Bases` descendant scan for NPC entities
- Character respawn entity refresh

Universal silent aim works on Fallen without V3's `VMNetworkPointer` hook, but **does not** do position manipulation behind walls — use V3-style manipulation only if we port that loop later.

### Game inner workings (shooting path)

```
Character clones controllers from ReplicatedStorage.CharacterScripts
  └─ ViewmodelController (equipped VM, fire rate, spread)
  └─ InventoryController.Fetch → toolbar + ammo
  └─ EquipController / StateController

Shoot:
  ViewmodelController → ray/bullet sim → MissFunction upvalue → AssetContainer network fire
  HitVFX → VFXModule.CreateBlood / CreateHole (V3 hooks here for tracers/sounds)

Hit detection server-side uses obfuscated remotes + client-reported CFrame/position args
```

`Modules.RaycastUtil` — shared raycast filters (humanoids, animals, vehicles, transparent parts).

`Modules.ToolInfo` / `ItemsModule` — weapon bullet speed, gravity, ammo types.

---



## What works from universal (Fallen)

- **Combat:** Silent Aim, Triggerbot, AutoFire, Hit Sounds, Bullet Tracers, Target Highlight
- **Movement:** Speed, Fly, Long Jump, No Fall
- **Visuals:** ESP, Chams, NameTags, Full Bright (no V3 AssetContainer proto hooks — higher ban risk on aggressive visuals)
- **Utility:** Anticheat Bypass module (always on), Auto Reconnect, FPS boost



### Fallen-specific `fallen_survival.lua` hooks

- Re-registers entities after respawn
- Watches `Animals`, `Events`, `Bases` for NPC fake entities
- Adds `workspace.VFX.VMs` to visualizer ignore list



### Future Fallen-only features

1. Port V3 **manipulation** + **fire remote hook** for wallbang silent aim
2. **Instant bullet** via ViewmodelController return-table hook
3. Gun info from `Modules.ToolInfo` for autofire tuning
4. Base ESP — `workspace.Bases` scan
5. AssetContainer proto hooks from `source.lua` (ESP/speed AC reports)

---



## RE workflow for agents

1. **Search dump:** `manifest/module_source_map.txt` → script path → `.lua` file
2. **Cross-reference remotes:** `manifest/remotes.txt`
3. **AssetContainer is obfuscated** — runtime `getgc` + `getconstants` on live client
4. **Bypass reference:** `reference/fishy_bypass.txt` + `fallen_ultimate_v3.lua` lines 222–395
5. **Silent aim reference:** `fallen_ultimate_v3.lua` lines 6785–7274 (targeting), 8480–8675 (fire hook)
6. **Test Medium (**`16849012343`**) and Large (**`13800717766`**)**



### Regenerating the dump

```powershell
python tools/fallen_rbxlx_merger.py
```

---



## Executor requirements

Fallen bypass requires:

- `cloneref`, `getgc`, `setrawmetatable`, `getrawmetatable`
- `rawget`, `rawset`, `rawlen`, `rawequal`
- `LPH_JIT` macros optional (stubbed when absent)

Full V3 feature port additionally needs: `hookfunction`, `debug.getupvalues`, `getconnections`, `isvalidlevel`, `setstack`.

---



## Quick checklist before testing

- [ ] Spawned in with character (HRP + Humanoid + Head)
- [ ] Bypass runs before universal (`getgenv().fishy_loaded` or `FallenBypassLoaded`)
- [ ] No kick `0x01`/`0x02` (legacy bypass — should not appear)
- [ ] Utility → Anticheat Bypass shows `Active` on Fallen
- [ ] Silent aim hits players; try Target.Walls on/off
- [ ] Rejoin after death — bypass re-runs on `CharacterAdded`