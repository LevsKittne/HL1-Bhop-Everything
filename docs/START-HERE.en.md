# From a request to working GoldSrc-style bhop

[English overview](../README.md) · [简体中文](START-HERE.zh-CN.md) · [Русский](START-HERE.md)

## 1. Give your assistant access

Use the game's source project when possible. For an installed game, provide its folder and known modding interface. A chat-only assistant needs the actual controller source or someone to execute its commands. File access and a usable movement extension point are prerequisites, not something a prompt can replace.

Use the prompt in the README. Choose `goldsrc-stock` or `classic-bhop`, whether to hold the jump key for automatic jumps, and whether to show UPS. If unsure, try `classic-bhop` in an isolated local test.

## 2. Require concrete identification

The assistant should identify the engine/version, controller class/file, movement function, up axis, velocity units, collision system, input source and local/server authority. A filename suggesting Unity is only a clue.

A useful result looks like: “Godot 4; Player.gd; _physics_process; CharacterBody3D; XZ velocity in metres/second; move_and_slide updates velocity; no server simulation in this project.” An unknown build needs more investigation rather than invented offsets.

## 3. Adapt the existing controller

Integrate into the existing movement owner. The standalone demos in examples are for learning and testing; replacing the game's whole controller can lose crouch, slopes, platforms or animation logic. For compiled games, prefer supported mod APIs/loaders and verified build-specific extension points. Read [compiled games](COMPILED-GAMES.md).

Detailed engine guides are currently in Russian. Ask the assistant to translate the relevant guide while preserving code identifiers, formulas, units and verification requirements.

## 4. Calibrate speed units

Measure normal running speed first. If the game runs at 7.5 world units/second and that should represent 300 GoldSrc UPS, the scale is `300 / 7.5 = 40`. The 30-UPS air projection cap becomes `30 / 40 = 0.75` world units/second. Copying 30 straight into a metre-based controller makes acceleration far too strong.

The examples use scale 40 for Unity/Godot and 0.4 for Unreal's centimetres. These are consistent example calibrations. Preserve the actual game's running speed unless the requested preset changes it.

## 5. Implement one simulation step

Sample/latch input → decide whether a jump is actually allowed → apply the stock limiter once on an accepted takeoff if enabled → ground friction or airborne mode → horizontal acceleration → vertical physics → the engine's sweep/slide collision → measured result.

GoldSrc air acceleration uses `min(wishspeed, 30)` for the projection limit but the **full wishspeed** for its acceleration impulse. Do not clamp total airborne speed to 30 UPS. Skip ground friction only on an accepted jump; holding jump beneath a low ceiling must not disable friction forever. See [algorithm](ALGORITHM.md) and [reference](../reference/goldsrc.py).

Grounded state may describe the previous physics move. Account for that update order; do not force grounded true. Hold-to-jump should trigger on the first eligible step after landing. Preserve normal jump height and game-specific eligibility.

## 6. Validate math and real movement

Run `python tools/check.py`, then the appropriate language/engine checks in [TESTING.md](TESTING.md). Test air with no input, A/D turning, stopping after releasing jump, repeated jumps, walls, low ceilings, crouch clearance and respawn. For multiplayer, test a real authoritative server and clients with matching movement and prediction.

[VALIDATION.md](../VALIDATION.md) separates actual passes from unrun editor/server checks. Portable math tests do not prove an engine component compiles. This repository does not promise complete HL1 collision, water or surf behavior.

## 7. Deliver a usable result and rollback

Require exact changed files, dependencies, build/run/install commands, parameters, unit conversion, measured tests and a way to restore the original state. Compiled games need build identification and verified originals. Keep backups outside the publishable source tree. Do not describe pseudocode or an untested binary as a working installed mod.

Useful next steps: [crouch / fall damage](JUMP-CROUCH-FALL.md), [UPS HUD](HUD.md), [networking](NETWORKING.md), [troubleshooting](TROUBLESHOOTING.md), [report template](../templates/implementation-report.md).
