# HL1-Bhop-Everything — GoldSrc / Half-Life 1 Bunnyhop Movement

**Add GoldSrc-style bunnyhopping to moddable 3D games with an AI coding assistant.** Engine guides, reference movement math, C++ / C# / GDScript examples, and regression tests for Unity, Unreal Engine, Godot and other 3D engines.

## Languages / 多语言 / Языки

| Language | Localized introduction |
| --- | --- |
| English | This page · [Step-by-step guide](docs/START-HERE.en.md) |
| Русский | [Баннихоп, распрыжка и воздушный стрейф](README.ru.md) |
| 简体中文 | [兔子跳 / 连跳教程：Unity、虚幻引擎、Godot](README.zh-CN.md) |
| 繁體中文 | [兔子跳 / 連跳教學：Unity、Unreal Engine、Godot](README.zh-TW.md) |
| Español | [Movimiento bunnyhop y aceleración aérea](README.es.md) |
| Português (Brasil) | [Movimentação bunnyhop e aceleração no ar](README.pt-BR.md) |
| 日本語 | [バニーホップ・連続ジャンプ・空中ストレイフ](README.ja.md) |
| 한국어 | [버니합·연속 점프·공중 스트레이프](README.ko.md) |
| Deutsch | [Bunnyhop-Bewegung und Beschleunigung in der Luft](README.de.md) |
| Français | [Déplacement bunnyhop et accélération aérienne](README.fr.md) |
| Türkçe | [Bunnyhop hareketi ve havada hızlanma](README.tr.md) |
| العربية | [حركة باني هوب والقفز المتتابع والتسارع في الهواء](README.ar.md) |

These are translated entry guides and AI prompts. The English and Simplified Chinese step-by-step guides are translated too; most detailed engine guides remain in Russian. Ask your assistant to translate the linked guide into your language while preserving formulas, units and test requirements. Translations do not imply that every engine example has been compiled.

## What this project does

Bhop keeps horizontal momentum across jumps. Air strafing accelerates along the intended direction using GoldSrc's projection rule; it is more than increasing a speed or air-control slider. The project supplies a portable planar reference and a workflow for adapting the game's actual controller.

**A working integration needs access to the movement controller:** source code, a supported mod API, or a verified extension point for the exact game build. This is a toolkit, not a universal ready-to-install patch for every game. Multiplayer needs matching authoritative simulation and prediction.

## Quick start

1. Download or clone this repository and open its folder in a coding assistant that can read and edit files.
2. Give it your game/project path and the prompt below.
3. Start with [the English walkthrough](docs/START-HERE.en.md), [中文入门](docs/START-HERE.zh-CN.md), or [the Russian walkthrough](docs/START-HERE.md). The assistant should identify the controller, implement the integration, build it and test actual movement.

```text
Read AGENTS.md and docs/START-HERE.en.md in this repository.
Add GoldSrc / Half-Life 1 style bunnyhop to my game/project: <PATH>.
Use classic-bhop with hold-to-jump, preserving normal jump height, collision,
input bindings and game-specific movement rules. Add a readable horizontal UPS meter.
Identify the engine/version, movement authority, velocity owner and unit scale first.
Integrate into the existing controller; do not run two controllers at once.
Read the relevant engine guide and translate it into my language as needed.
Implement, build, test and provide installation plus rollback instructions.
Report missing engine/server tests honestly; do not stop at pseudocode.
```

For more control, choose `goldsrc-stock` (HL1 takeoff speed limiter) or `classic-bhop` (limiter disabled). Hold-to-jump is a separate mod feature. See [presets](config/presets.json) and [the algorithm](docs/ALGORITHM.md).

## Choose an engine

| Engine / access | Guide | Included example |
| --- | --- | --- |
| Unity source project | [Unity](docs/UNITY.md) | Pure C# math and a local CharacterController demo |
| Unity Mono / IL2CPP compiled game | [Compiled games](docs/COMPILED-GAMES.md) | Build identification, extension points, ABI and rollback workflow |
| Unreal Engine | [Unreal](docs/UNREAL.md) | Portable C++ math, local Pawn demo, CMC / Blueprint integration guidance |
| Godot 4 | [Godot](docs/GODOT.md) | Runnable CharacterBody3D project with math and runtime tests |
| Stride, O3DE, CryEngine, Source / idTech, custom engine | [Other engines](docs/OTHER-ENGINES.md) | Adapter contract and integration checklist |
| Unknown engine | [Engine detection](docs/ENGINE-DETECTION.md) | Evidence, version checks and how to choose an approach |

The engine guides in this table are currently in Russian. Use the translated walkthroughs above and ask your assistant to translate the relevant guide.

## Movement and tests

- GoldSrc ground/air acceleration, ground friction, air projection cap, and stock bunny limiter are covered by shared fixtures.
- Keep engine gravity, collision, crouch clearance and platform behavior coherent with one movement owner. See [jump / crouch / fall damage](docs/JUMP-CROUCH-FALL.md).
- Calibrate units: the Unity/Godot examples use 40 GoldSrc units per world unit; Unreal uses 0.4 per centimetre. These are example calibrations, not mandatory engine constants.
- [UPS HUD](docs/HUD.md) measures horizontal speed in GoldSrc units per second. [Networking](docs/NETWORKING.md) covers authority and prediction.

```shell
python tools/check.py
```

See [test commands](docs/TESTING.md) and [what was actually validated](VALIDATION.md). Passing portable math does not prove Unity or Unreal editor integration or a network match. This is not a complete port of HL1 collision, water or surf behavior.

## Find, share and contribute

Search terms include **bhop, bunnyhop, bunny hopping, GoldSrc movement, Half-Life movement, air strafing, autojump, 兔子跳, 连跳, 連跳, バニーホップ, 버니합, баннихоп, распрыжка**. These describe the same movement topic across communities; the engine integration still depends on the game.

See [search tips and indexing limits](docs/DISCOVERY.md), [contributing](CONTRIBUTING.md), [game profile](templates/game-profile.json), [implementation report](templates/implementation-report.md), and [primary sources](SOURCES.md). AI tools supporting reusable skills can use [SKILL.md](SKILL.md); others can start with the prompt and [AGENTS.md](AGENTS.md).

Own documentation and examples are [MIT licensed](LICENSE). No proprietary game binaries, private build offsets or Valve sprites are included.
