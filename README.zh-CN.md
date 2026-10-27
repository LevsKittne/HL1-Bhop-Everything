# HL1-Bhop-Everything — GoldSrc 兔子跳 / 连跳教程

[English / Languages / 多语言 / Языки](README.md) · **简体中文**

使用 AI 编程助手，为可修改的 Unity、Unreal Engine（虚幻引擎）、Godot 和其他 3D 游戏集成 Half-Life 1 / GoldSrc 风格的兔子跳（bhop）、空中加速和自动连跳。包含 C++、C#、GDScript 数学实现、引擎示例和测试。

## 快速开始

下载仓库，在能读写文件的 AI 工具中打开，然后填写真实的游戏或项目路径。先阅读中文分步教程，再使用下面的提示词。

[中文分步教程](docs/START-HERE.zh-CN.md)

```text
请阅读本仓库的 AGENTS.md 和 docs/START-HERE.zh-CN.md。
为我的游戏/项目 <路径> 添加 GoldSrc / Half-Life 1 风格的 classic-bhop、
按住跳跃键自动连跳，以及清晰的水平 UPS 速度计。
先确认引擎版本、单位比例、速度写入点和客户端/服务器权限模型。
在现有控制器中集成，保留正常跳跃高度、碰撞、蹲下检测和按键。
将对应引擎指南翻译成中文；保持公式、单位和代码标识符不变。
请实现、构建、实际测试，并提供安装与回退步骤。
无法运行的测试请明确说明，不要只给伪代码。
```

需要访问源代码、模组 API 或经过验证的扩展点。不是任何游戏都能直接安装的通用补丁。联网游戏需要一致的服务器模拟和客户端预测。

`goldsrc-stock`: HL1 / GoldSrc · `classic-bhop`: stock limiter disabled.

## 翻译范围

本页和中文分步教程已翻译；详细引擎文档目前主要为俄语。可让 AI 翻译对应指南，并保留公式、单位和测试要求。实际测试范围见 VALIDATION.md。

[Unity](docs/UNITY.md) · [Unreal Engine](docs/UNREAL.md) · [Godot](docs/GODOT.md) · [Algorithm](docs/ALGORITHM.md) · [Tests](docs/TESTING.md) · [VALIDATION.md](VALIDATION.md) · [MIT](LICENSE)
