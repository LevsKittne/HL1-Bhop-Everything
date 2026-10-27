# Unreal Engine

## Сначала выясни контроллер

Unreal-персонаж может использовать CharacterMovementComponent (CMC), Mover, собственный PawnMovementComponent, Gameplay Ability/root motion или иной контроллер. Изменение одной переменной AirControl не является переносом PM_AirAccelerate.

## Путь A: маленький локальный Pawn-пример

examples/unreal содержит BhopPawn.h/.cpp и BhopPawnMovement.h/.cpp. Это **standalone teaching demo для UE5**, не сетевой CMC replacement. C++-ядро лежит в examples/cpp/bhop_core.hpp. Для UE4 нужны адаптация указателей/API и отдельная сборка.

1. В C++-проекте создай папку Source/<твой модуль>/Bhop и скопируй четыре Unreal-файла. Скопируй bhop_core.hpp рядом с ними. В Build.cs нужны обычные Core, CoreUObject, Engine и InputCore.
2. Пересобери через редактор/IDE. Если UHT/компилятор сообщает ошибку, сохрани полный вывод и адаптируй API своей версии; наличие файлов в наборе не означает сборку в твоём SDK.
3. Создай Blueprint, основанный на BhopPawn, поставь его над полом с collision. Он имеет capsule, camera и AutoPossess Player0. Удали/отключи другой auto-possessed pawn в этой тестовой сцене.
4. Для демо добавь legacy axes MoveForward=W/S, MoveRight=D/A, Turn=MouseX, LookUp=MouseY и action Jump=Space в настройках ввода проекта. Для Enhanced Input свяжи свои actions с публичными методами pawn, сохраняя pressed/released для Jump.
5. Запусти в Standalone. Значения демо: 300 GS maxspeed, scale=0.4 GS/см, gravity=2000 см/с², высота прыжка=75 см. Стрейф использует чистое ядро, collision — sweep/slide Unreal.

Пример сознательно не симулирует сеть и не реализует production step-up, crouch, платформы и лестницы. Он даёт проверяемую точку старта. Настоящий FPS-контроллер лучше менять в его родной системе.

## Путь B: встроить в CMC

1. Найди реально используемый subclass UCharacterMovementComponent. Подключай его через конструктор Character/существующий factory, а не добавляй второй movement component.
2. Проверь исходники `PhysWalking`, `PhysFalling`, `CalcVelocity` именно версии проекта. Они могут вычислять velocity, применять braking, AirControl, root motion и повторно ограничивать скорость. [CalcVelocity](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/UCharacterMovementComponent/CalcVelocity?lang=en-US) не добавляет гравитацию.
3. Замени один горизонтальный шаг и не вызывай второй раз штатное ускорение поверх него. Стрейф не должен теряться из-за дополнительного clamp ниже по стеку. Исключи воду, flying, root motion и другие неохваченные режимы из своей ветки.
4. Срез stock-bhop вызывай на принятом прыжке, а не в каждом CalcVelocity при IsFalling. Сохраняй результат CanJump, лимиты jump count и голову под потолком. Сигнатура DoJump меняется: в новых API есть bool,float overload; прочитай заголовок проекта, не копируй устаревший override вслепую.
5. Реализуй hold-to-bhop в воспроизводимом input/state, учитывая reset jump state при приземлении. Для сети включи нужные данные в saved moves и серверный replay.

CMC может пересчитать движение несколько раз за тик из-за смены режима и подшагов. Не добавляй к нему ещё один независимый Tick с импульсом. [Устройство CMC и сети](https://dev.epicgames.com/documentation/en-us/unreal-engine/understanding-networked-movement-in-the-character-movement-component-for-unreal-engine).

## Blueprint-only

Чистую формулу можно собрать как функцию: входы velocity2D, wish2D, dt, maxspeed, surface friction, grounded, accepted jump; выход velocity2D. Нужны Length, Normalize, Dot, Min/Max и ветки из ALGORITHM.md. Но место вызова важнее формулы: обычный Event Tick поверх CharacterMovement не заменяет его solver.

Для собственного MOVE_Custom следуй UpdateCustomMovement/PhysCustom и реализуй sweep, floor, slide, step и сеть этого режима. Если проект не имеет подходящего Blueprint hook, ИИ должен предложить C++-точку расширения, а не телепортировать Character через SetActorLocation без сохранения сетевой модели.

Mover требует отдельного адаптера и проверки текущего API. Статус и интерфейсы Mover меняются; следуй [документации своей версии](https://dev.epicgames.com/documentation/en-us/unreal-engine/mover-in-unreal-engine).
