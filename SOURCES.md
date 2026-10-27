# Источники и происхождение примеров

Сверка документации: 2026-10-27. Используй API именно своей версии движка; stable/latest страницы со временем меняются.

| Область | Первичный источник |
| --- | --- |
| Формулы HL1 | [Valve pm_shared.c](https://github.com/ValveSoftware/halflife/blob/master/pm_shared/pm_shared.c) |
| Параметры GoldSrc | [ReHLDS sv_user.cpp](https://github.com/rehlds/ReHLDS/blob/master/rehlds/engine/sv_user.cpp), [sv_phys.cpp](https://github.com/rehlds/ReHLDS/blob/master/rehlds/engine/sv_phys.cpp), [sv_main.cpp](https://github.com/rehlds/ReHLDS/blob/master/rehlds/engine/sv_main.cpp) |
| Спидометр BXT | [Bunnymod XT hud_custom.cpp](https://github.com/YaLTeR/BunnymodXT/blob/master/BunnymodXT/hud_custom.cpp) |
| Unity Move | [CharacterController.Move](https://docs.unity3d.com/6000.0/Documentation/ScriptReference/CharacterController.Move.html) |
| Unity grounding / steps | [Unity CharacterControllerSamples](https://github.com/Unity-Technologies/CharacterControllerSamples) |
| Unreal velocity | [CMC CalcVelocity](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/UCharacterMovementComponent/CalcVelocity?lang=en-US) |
| Unreal jump | [CMC DoJump overloads](https://dev.epicgames.com/documentation/en-us/unreal-engine/API/Runtime/Engine/UCharacterMovementComponent/DoJump) |
| Unreal network | [Networked movement](https://dev.epicgames.com/documentation/en-us/unreal-engine/understanding-networked-movement-in-the-character-movement-component-for-unreal-engine) |
| Godot | [CharacterBody3D](https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html), [официальные релизы](https://github.com/godotengine/godot/releases) |
| Stride | [CharacterComponent](https://doc.stride3d.net/latest/en/api/Stride.Physics.CharacterComponent.html) |
| O3DE | [Physics::Character](https://docs.o3de.org/docs/api/frameworks/azframework/class_physics_1_1_character.html) |
| CryEngine | [Creating a Player using C++](https://www.cryengine.com/docs/static/engines/cryengine-5/categories/23756816/pages/101679110) |

Ядра и engine-примеры написаны для этого набора как собственные реализации математических правил и учебные адаптеры. Исходные файлы HL1 SDK, BXT, игровых движков и игровые ресурсы в набор не копировались. Ссылки и изучение API не меняют лицензию исходных проектов. MIT относится к собственным материалам этого репозитория.
