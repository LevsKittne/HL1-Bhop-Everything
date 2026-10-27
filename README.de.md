# HL1-Bhop-Everything — Bunnyhop-Bewegung nach GoldSrc / Half-Life 1

[English / Languages / 多语言 / Языки](README.md) · **Deutsch**

Anleitungen für KI-Programmierassistenten, um Bunnyhop (bhop), automatisches Springen und Beschleunigung in der Luft in modifizierbare 3D-Spiele einzubauen. Mit Leitfäden für Unity, Unreal Engine und Godot, Beispielen in C++, C# und GDScript sowie gemeinsamen Tests.

## Erste Schritte

Lade das Repository herunter, öffne es in einem Assistenten mit Dateizugriff und ersetze <PFAD> durch den tatsächlichen Spiel- oder Projektpfad.

[Englische Schrittanleitung](docs/START-HERE.en.md)

```text
Lies AGENTS.md und docs/START-HERE.en.md.
Ergänze das Spiel/Projekt <PFAD> um classic-bhop, automatisches Springen bei
gehaltener Sprungtaste und eine lesbare Anzeige der horizontalen UPS.
Ermittle zuerst Engine, Einheiten, die zuständige Geschwindigkeitsfunktion und Bewegungsautorität.
Integriere die Änderung in den bestehenden Controller. Erhalte normale Sprunghöhe,
Kollisionen, Platzprüfung beim Ducken und Steuerung. Übersetze den Engine-Leitfaden ins Deutsche.
Implementiere, baue und teste. Liefere Installation, Wiederherstellung und tatsächliche Ergebnisse.
Nenne nicht durchgeführte Tests ausdrücklich; liefere nicht nur Pseudocode.
```

Quellcode, eine Mod-API oder ein verifizierter Erweiterungspunkt sind erforderlich. Dies ist kein universeller Patch. Im Mehrspielermodus müssen Serversimulation und Client-Vorhersage dieselben Bewegungsregeln verwenden.

`goldsrc-stock`: HL1 / GoldSrc · `classic-bhop`: stock limiter disabled.

## Umfang der Übersetzung

Diese Einführung und der KI-Auftrag sind auf Deutsch. Es gibt eine englische Schrittanleitung; die ausführlichen Engine-Leitfäden sind überwiegend russisch. Bitte die KI um eine Übersetzung mit unveränderten Formeln, Einheiten und Testanforderungen. Den tatsächlichen Prüfstand zeigt VALIDATION.md.

[Unity](docs/UNITY.md) · [Unreal Engine](docs/UNREAL.md) · [Godot](docs/GODOT.md) · [Algorithm](docs/ALGORITHM.md) · [Tests](docs/TESTING.md) · [VALIDATION.md](VALIDATION.md) · [MIT](LICENSE)
