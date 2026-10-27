# HL1-Bhop-Everything — GoldSrc 兔子跳 / 連跳教學

[English / Languages / 多语言 / Языки](README.md) · **繁體中文**

使用 AI 程式設計助手，為可修改的 Unity、Unreal Engine（虛幻引擎）、Godot 與其他 3D 遊戲加入 Half-Life 1 / GoldSrc 風格的兔子跳（bhop）、空中加速與自動連跳。包含 C++、C#、GDScript 數學實作、引擎範例和測試。

## 快速開始

下載儲存庫，在能讀寫檔案的 AI 工具中開啟，填入實際的遊戲或專案路徑，再使用下方提示詞。

[英文分步指南](docs/START-HERE.en.md)

```text
請閱讀 AGENTS.md 與 docs/START-HERE.en.md。
為我的遊戲／專案 <路徑> 加入 GoldSrc 風格的 classic-bhop、
按住跳躍鍵自動連跳，以及清楚的水平 UPS 速度計。
先確認引擎版本、單位換算、速度寫入點與客戶端／伺服器權限模型。
整合現有控制器，保留正常跳躍高度、碰撞、蹲下空間檢查與按鍵。
將對應引擎指南翻譯為繁體中文，保持公式、單位和程式碼識別字不變。
請實作、建置、測試，並提供安裝與還原步驟；誠實列出未執行的測試。
```

需要原始碼、模組 API 或經過驗證的擴充點；這不是適用所有遊戲的通用安裝補丁。多人遊戲需要一致的伺服器模擬和客戶端預測。

`goldsrc-stock`: HL1 / GoldSrc · `classic-bhop`: stock limiter disabled.

## 翻譯範圍

本頁為繁體中文入門；另有英文與簡體中文分步指南。詳細引擎文件目前主要是俄文，可請 AI 翻譯並保留公式、單位與測試要求。實際驗證範圍請看 VALIDATION.md。

[Unity](docs/UNITY.md) · [Unreal Engine](docs/UNREAL.md) · [Godot](docs/GODOT.md) · [Algorithm](docs/ALGORITHM.md) · [Tests](docs/TESTING.md) · [VALIDATION.md](VALIDATION.md) · [MIT](LICENSE)
