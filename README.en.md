# HL1-Bhop-Everything

An AI-assisted cookbook for adding GoldSrc-style bunnyhopping to moddable 3D games. Includes a language-independent reference, C++, C# and GDScript math ports, Unity and Unreal integration examples, a runnable Godot project, test vectors, and engine-specific instructions.

This is an adaptation workflow, not a universal injector. The game must expose a source controller, a modding interface, or a build-specific extension point. Multiplayer needs matching server-side simulation and prediction.

Most detailed tutorials are in Russian. Ask your assistant to translate them while preserving the formulas and validation requirements:

```text
Read AGENTS.md and docs/START-HERE.md in this repository.
Add GoldSrc-style bhop to my game/project at: <PATH>.
Respond in English and translate the engine-specific guide as needed.
Preserve collision, normal jump height and input bindings. Identify the engine,
movement authority, and velocity owner before editing. Implement, build and test
the result. Report missing engine tests honestly; do not stop at pseudocode.
```

Start with [README](README.md), [engine detection](docs/ENGINE-DETECTION.md), [algorithm](docs/ALGORITHM.md), and [test commands](docs/TESTING.md). Check [VALIDATION.md](VALIDATION.md) for what was actually run. MIT license; no proprietary game binaries or Valve sprites included.
