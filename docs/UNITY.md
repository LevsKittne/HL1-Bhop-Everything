# Unity: проект, Mono и IL2CPP

## Исходный проект — самый короткий путь

1. Найди активный Player prefab и компонент, который вызывает CharacterController.Move, управляет Rigidbody либо ECS-персонажем. Установи владельца записи скорости.
2. Для существующего контроллера перенеси только горизонтальный шаг из examples/unity/BhopMath.cs. Держи скорость между шагами; не присваивай wish velocity каждый кадр.
3. Сохрани штатный grounded, возможность прыжка, гравитацию, настройки наклона/ступеней, платформы и сетевой update. Проверь, не применяется ли дополнительный drag/ускорение после нового шага.
4. Переведи реальные world velocity и wish в GS units, вызови ядро, верни XZ в мировые единицы. Y обслуживает существующая вертикальная физика.
5. Получай jump-held из назначенного InputAction/системы игры; одиночное нажатие защёлкивай до физического шага. Не добавляй новый жёсткий Space поверх переназначенного ввода.

`CharacterController.Move` принимает **смещение**, поэтому один раз умножай итоговую скорость на dt. Он сам не добавляет гравитацию. `isGrounded` относится к последнему Move. [Unity API](https://docs.unity3d.com/6000.0/Documentation/ScriptReference/CharacterController.Move.html).

## Локальная демонстрация

Скопируй BhopMath.cs и SimpleBhopCharacter.cs в Assets/Scripts. Создай площадку с Collider, Player с CharacterController и дочернюю Camera, назначь Camera в поле View. Поставь игрока выше пола. Запусти сцену без второго компонента движения.

В демо есть ввод через старый Input Manager (Horizontal, Vertical, Jump, Mouse X/Y), если включён ENABLE_LEGACY_INPUT_MANAGER. Для нового Input System вызывай `SubmitInput(move, jumpHeld)` из своих InputAction callbacks; выставь `ReadLegacyInput=false`. Ассистент должен связать ввод существующего проекта, а не считать наличие пакета гарантированным.

Это CharacterController-пример для одиночной сцены. Он не является готовым сетевым контроллером, системой приседа, root-motion интеграцией или заменой ECS-контроллера.

## Rigidbody

Используй физический timestep. Передавай скорость через API версии своего Rigidbody; учитывай встроенные gravity/drag и ограничения вращения. Если добавляешь impulse/force, учитывай массу и ForceMode. Не вызывай CharacterController.Move и Rigidbody-движение для одного тела. После столкновений не возвращай старую скорость внутрь стены.

## Готовая игра

Mono и IL2CPP — разные маршруты. Для Mono найди поддерживаемый loader и управляемый метод; для IL2CPP нужны совместимые bindings/hooks или нативное исследование. Версии loader/игры и архитектура должны совпадать. Читай [COMPILED-GAMES.md](COMPILED-GAMES.md). Наличие managed-looking proxy DLL у IL2CPP не превращает нативный метод в IL.

Для Unity DOTS/других контроллеров адаптируй шаг к их реальному циклу, а не копируй MonoBehaviour рядом. [Пример character controller Unity](https://github.com/Unity-Technologies/CharacterControllerSamples) полезен для проверки ступеней и склона.
