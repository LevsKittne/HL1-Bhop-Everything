# HL1-Bhop-Everything — GoldSrc のバニーホップ・連続ジャンプ

[English / Languages / 多语言 / Языки](README.md) · **日本語**

AI コーディング支援を使い、改造可能な 3D ゲームへ Half-Life 1 / GoldSrc 風のバニーホップ（bhop）、空中ストレイフ、オートジャンプを組み込むためのガイドです。Unity、Unreal Engine、Godot 向けの説明、C++・C#・GDScript の計算例とテストを収録しています。

## 始め方

リポジトリをダウンロードし、ファイルを読み書きできる AI ツールで開きます。次の依頼文の <パス> を実際のゲームやプロジェクトのパスに置き換えてください。

[英語の手順書](docs/START-HERE.en.md)

```text
AGENTS.md と docs/START-HERE.en.md を読んでください。
ゲーム／プロジェクト <パス> に GoldSrc 風の classic-bhop、
ジャンプキーを押している間の自動ジャンプ、見やすい水平 UPS メーターを追加してください。
まずエンジン、単位変換、速度を書き込む処理、移動の権限モデルを確認してください。
既存のコントローラーに統合し、通常のジャンプ高度、衝突、しゃがみ時の空間判定、操作を保ってください。
該当するエンジンのガイドを日本語に翻訳し、数式と単位は保持してください。
実装・ビルド・テストを行い、導入方法と元に戻す手順を示してください。
未実施のテストを明記し、疑似コードだけで完了としないでください。
```

ソースコード、Mod API、または検証済みの拡張ポイントが必要です。すべてのゲームにそのまま使えるパッチではありません。マルチプレイではサーバーのシミュレーションとクライアント予測を一致させる必要があります。

`goldsrc-stock`: HL1 / GoldSrc · `classic-bhop`: stock limiter disabled.

## 翻訳の範囲

この導入ページと AI への依頼文は日本語です。英語の手順書もありますが、詳細なエンジンガイドは主にロシア語です。数式、単位、検証要件を保って翻訳するよう依頼してください。実際の検証状況は VALIDATION.md を参照してください。

[Unity](docs/UNITY.md) · [Unreal Engine](docs/UNREAL.md) · [Godot](docs/GODOT.md) · [Algorithm](docs/ALGORITHM.md) · [Tests](docs/TESTING.md) · [VALIDATION.md](VALIDATION.md) · [MIT](LICENSE)
