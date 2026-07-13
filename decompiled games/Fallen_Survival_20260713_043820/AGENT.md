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
    ├── bypas.txt               ← Combined ban-table bypass (#1 + #2) + fishy (#3) reference
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

### Combined bypass (`libraries/fallen_bypass.lua`)

Fallen needs **all three** stages from `reference/bypas.txt` + `reference/fishy_bypass.txt` (Iridescent `source.lua` uses the same stack):

| Stage | What | When |
|-------|------|------|
| **#1** | Neutralize Remotes GC ban table (`rawget(tbl,4)` on table whose `[1]` is `Remotes` Instance) | First `getgc` pass after spawn |
| **#2** | Neutralize per-character 9-entry table (`[1]=Character`, `[2]=Humanoid`) — hook indices 5 + 8, nil index 5 | After character exists; **re-run on respawn** |
| **#3** | Fishy recursive self-table `__newindex` hook | Continuous / respawn retry |

`status.Bypass1/2/3` and `vape.Libraries.fallenBypass` report which stages succeeded. On Fallen, all three must pass or the client is kicked.

**AssetContainer proto hooks** (`games/fallen_survival.lua`): after bypass Active, neuter proto-1 on `getgc` functions whose constants match `SurfaceGui`, `Foundation`, `LocalAmmo`+`Equipped`, `WalkSpeed` — same fingerprints as Iridescent `source.lua`.

### Detection vectors — do NOT use on Fallen

| Vector | Why banned | What we use instead |
|--------|------------|---------------------|
| Iridescent **Anti Aim** (`Root.CFrame` yaw + `TorsoController.Look:FireServer`) | Server validates torso look remotes | **Universal Desync** — brief `HRP.CFrame * rot` on Heartbeat, restore next frame |
| Third person **HRP yaw snap** to camera | Persistent CFrame writes outside desync pulse | Third person = camera mode + zoom only (no root rotation) |
| Fallen-specific pitch via TorsoController | Same as above | Desync angles only (0–180° pitch/yaw), no position desync |
| Wrong flashpoint stack spoof | AC reads ViewmodelController stack slots | Fixed indices **45/51/52/54** (Iridescent), dynamic scan fallback |

### Desync + Blink (`libraries/fallen_exploits.lua`)

**One module: Desync** (Blatant) — universal CFrame angle desync + camera proxy + visualizer + reach ring.

- **No separate Anti Aim module** — Iridescent-style anti aim is intentionally removed.
- Enable **Desync** first; sets `FS.desyncAnchor` + `FS.desyncReach` (1–8 studs).
- **Blink** chokes movement packets (`S2PhysicsSenderRate=0`); auto-disables when `|HRP - anchor| > reach`.
- `FS.currentDesyncRotation` feeds Blink visualizer when desync angles are active.
- Desync skips while `vape.Libraries.silentAimHookBusy` (silent aim stack/network hooks).

### Silent aim + manipulation flashpoint (`games/fallen_survival.lua`)

Match Iridescent `source.lua` CreateProjectile hook:

1. **Stack rewrite** at level 3: slots 45=camera CFrame, 51=flashpart Vector3, 52=HRP CFrame, 54=hit Vector3.
2. With **manipulation**: rebase camera/HRP/flash from `ManipulatedPosition` using flash offsets (same math as source).
3. **Args rewrite**: `Position`, `Direction`, `PositionFirst`, `DirectionFirst` from manipulated origin when set.
4. **VMNetworkPointer** 8-arg fire: rewrite `CameraCFrame`, `CharacterCFrame`, `MuzzlePos`, `MouseRaycast` with manipulation origin.
5. Wrap hooks with `silentAimHookBusy` so desync does not fight stack spoof.

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
| `games/fallen_survival.lua`                 | Pass 1 Fallen script — silent aim, gun mods, ESP, visuals; strips universal Combat/Render |
| `games/16849012343.lua` / `13800717766.lua` | Thin Fallen loaders (`downloadFile` → fallen_survival)                                    |




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
| `insulin.lua`            | Insulin — best manipulation/hitscan silent aim math (Pass 1 combat source) |


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


**On Fallen:** Pass 1 replaces universal Silent Aim with insulin-style hooks in `fallen_survival.lua` (CreateProjectile + VMNetworkPointer + manipulation/hitscan). Universal Combat/Render modules are stripped at load.

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

Universal still loads for entitylib + shared utilities. Conflicting Combat/Blatant/Render/World modules are **stripped** by allen_survival.lua via ape:Remove.

**Kept:** Anticheat Bypass, Panic, Rejoin, ServerHop, Rejoin Previous Server, FPS, AutoRejoin, StaffDetector, Friends/Targets Main options, GUI.

---

## Vape Pass 1 — games/fallen_survival.lua

~3.2k lines. Shared profile: Medium + Large under canon place 16849012343 (SHARED_GAME_CONFIGS.FALLEN in guis/new.lua).

### Load order

`
main.lua → fallen_bypass.lua → universal.lua → games/<PlaceId>.lua → fallen_survival.lua → vape:Load()
`

Place stubs (16849012343.lua / 13800717766.lua) use downloadFile so missing executor cache no longer errors with 
eadfile File not found.

### Modules registered

| Category | Module | Source |
|----------|--------|--------|
| Combat | **Fallen Silent Aim** | insulin targeting + manip/hitscan + CreateProjectile + VMNetworkPointer |
| Combat | **Fallen Gun Mods** | insulin AttachmentStats / ToolInfo / RaycastUtil |
| Render | **Fallen Player ESP** | Iridescent-style box/skeleton/chams/name/dist/weapon/flags |
| Render | **Fallen AI ESP** | Military Soldier |
| Render | **Fallen Boss ESP** | Brutus/Bruno/Boris/BTR |
| Render | **Fallen World ESP** | Nodes, body bags, items, raids, crates, care packages, sleepers, plants |
| Render | **Fallen Crosshair** | Iridescent crosshair settings |
| Render | **Fallen Bullet Tracers** | CreateBlood/CreateHole + shot queue origin |
| Render | **Fallen Hitmarkers** | Same hit hooks |
| Render | **Fallen Lighting** | Fullbright / ambient / time / fog / bloom / remove grass |
| Render | **Fallen XRay Bases** | Base mesh transparency |
| Render | **Fallen Viewmodel Sandbox** | Item/arm chams on workspace.VFX.VMs |

### Silent Aim hook map

| Piece | Mechanism |
|-------|-----------|
| Targeting Heartbeat | FOV pick + visibility; manip/hitscan only when not LOS |
| manipOffsets / FindVisiblePosition | insulin head-local offsets + 3 reachability tests |
| GetHitScanPos | surface aim point along UnitDirections |
| VFXModule.CreateProjectile | filter inject, prediction, stack rewrite, Position/Direction |
| VMNetworkPointer | getgc discover (ViewmodelController Parent/CFrame); 8-arg fire rewrite |
| RaycastUtil.Raycast | Instant Bullet snap + Reach x10 |
| Memory mode | Camera.CFrame = lookAt(target) |

### AssetContainer proto hooks

After bypass Active, scans getgc for AssetContainer functions and neuters proto-1 when constants match: SurfaceGui, Foundation, LocalAmmo+Equipped, WalkSpeed.

Status: ape.Libraries.fallen.AssetContainerHooked.

### Deferred (not in Pass 1)

Misc movement (Fly, Silent Step, Bunnyhop, Omnisprint, NoFall) in `libraries/fallen_movement.lua`. Desync/Blink/Third Person/Underground in `libraries/fallen_exploits.lua`. Deferred: Auto Upgrade, Instant Loot, Disable Turrets, Skins, Armor Viewer, Killaura, Fat Bullet, Instant Eoka, Double Shot, full AssetContainer proto suite beyond the four fingerprints above.

### Runtime verification checklist

- [ ] Inject after full spawn — no readfile error; Anticheat Bypass = Active
- [ ] Universal SilentAim/ESP gone from GUI; Fallen modules present
- [ ] Silent Aim hits LOS targets; Manipulation + HitScan work through cover
- [ ] Player/AI/Boss ESP + chams render; World ESP labels appear
- [ ] Tracers + hitmarkers fire on local shots
- [ ] Gun Mods (no recoil / instant bullet) apply via ViewmodelController traceback
- [ ] Medium (16849012343) and Large (13800717766) share profile

---

## RE workflow for agents

1. Search dump: manifest/module_source_map.txt → script path → .lua file
2. Cross-reference remotes: manifest/remotes.txt
3. AssetContainer is obfuscated — runtime getgc + getconstants on live client
4. Bypass reference: `reference/bypas.txt` + `reference/fishy_bypass.txt` → `libraries/fallen_bypass.lua`
5. Silent aim reference: `reference/insulin.lua` + Iridescent `source.lua` stack slots 45/51/52/54
6. ESP/visuals reference: `reference/source.lua` (Iridescent)
7. Test Medium (16849012343) and Large (13800717766)

### Regenerating the dump

`powershell
python tools/fallen_rbxlx_merger.py
`

---

## Executor requirements

Fallen bypass requires:

- cloneref, getgc, setrawmetatable, getrawmetatable
- 
awget, 
awset, 
awlen, 
awequal
- LPH_JIT macros optional (stubbed when absent)

Pass 1 combat/ESP additionally needs: hookfunction, debug.getinfo / getconstants / getprotos / getproto / getupvalue / getstack / setstack (setstack optional), islclosure, Drawing API optional for skeleton/boxes.

---

## Quick checklist before testing

- [ ] Spawned in with character (HRP + Humanoid + Head)
- [ ] Bypass runs before universal (getgenv().fishy_loaded or FallenBypassLoaded)
- [ ] No kick 0x01/0x02 (legacy bypass — should not appear)
- [ ] Utility → Anticheat Bypass shows Active on Fallen
- [ ] Combat → Fallen Silent Aim works; try Manipulation + Hit Scan
- [ ] Render → Fallen Player ESP / World ESP visible
- [ ] Rejoin after death — bypass re-runs on CharacterAdded
