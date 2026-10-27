# Как определить движок и доступ

Сначала исследуй указанную пользователем папку. Не запускай исполняемые файлы для одной лишь классификации. Пригодится `python tools/fingerprint.py <ПУТЬ>`: он читает признаки и хеши файлов, но не доказывает совместимость мода.

| Признак | Гипотеза | Следующая проверка |
| --- | --- | --- |
| Assets/, ProjectSettings/ProjectVersion.txt | Unity-проект | Версия, исходный Player/Controller, Input System |
| UnityPlayer + *_Data/Managed/Assembly-CSharp.dll | Unity Mono | Реальная архитектура/версия, кто пишет velocity |
| GameAssembly + il2cpp_data/Metadata/global-metadata.dat | Unity IL2CPP | Точный хеш и native/metadata-пара для этой сборки |
| .uproject, Source/, Content/ | Unreal-проект | EngineAssociation, Pawn/Character, CMC/Mover |
| .pak/.ucas/.utoc и Engine/ | Возможная сборка Unreal | Логи/документация игры, поддерживаемый mod API |
| project.godot и .gd/.tscn | Godot-проект | Версия, CharacterBody3D/KinematicBody, способ сборки |
| .pck | Возможный Godot export | Подтверждение движка и доступный исходный проект/mod API |
| .sln/.csproj/.cpp без явных признаков | Свой или другой движок | Зависимости, update loop, физический backend |

Один файл может оказаться ресурсом, библиотекой или чужим инструментом. Проверяй несколько независимых признаков. DLL с именем GameAssembly не задаёт фиксированных адресов функций.

Затем выбери путь: исходники → правка контроллера; API/loader → мод; неподдерживаемая готовая игра → исследование сборки. Не переименовывай EXE/DLL в надежде сменить runtime. Для Linux/macOS уточни формат модуля и архитектуру отдельно.
