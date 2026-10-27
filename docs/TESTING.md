# Команды и критерии проверки

## Без движка

Из корня репозитория:

```shell
python tools/check.py
```

Это 10 000 случайных воздушных проверок Python-эталона, фиксированные регрессии, 522 общих сценария и ссылки документов. CSV включает трение, аналоговый ввод, maxspeed, два режима limiter и разные dt. Не выдавай этот результат за проверку игрового controller.

## C++17

Linux/macOS с доступным компилятором:

```shell
mkdir -p .build
c++ -std=c++17 -O2 tests/test_core.cpp -o .build/test_core
.build/test_core tests/cases.csv
```

Windows: открой x64 Native Tools Command Prompt Visual Studio, создай .build и выполни:

```bat
cl /nologo /std:c++17 /EHsc tests\test_core.cpp /Fe:.build\test_core.exe /Fo:.build\test_core.obj
.build\test_core.exe tests\cases.csv
```

## C#-ядро

Нужен .NET SDK, поддерживающий net8.0:

```shell
dotnet run --project tests/csharp/CoreChecks.csproj -- tests/cases.csv
```

Это компилирует тот же BhopMath.cs, который подключается в Unity, но не компилирует MonoBehaviour против UnityEngine. Порог расхождения C++/C#/GDScript — 0.002 GS units/s из-за float32; допуск не является доказательством сетевой синхронизации.

## Godot

```shell
godot --headless --path examples/godot --editor --import
godot --headless --path examples/godot --script res://test_math.gd
godot --headless --fixed-fps 60 --path examples/godot --script res://test_runtime.gd
```

Первая команда импортирует скрипты и обнаруживает parser errors. Вторая запускает CSV через GDScript. Третья создаёт настоящую сцену, проверяет пол, разгон по земле, несколько взлётов на удержании, приземление/остановку, наличие HUD, стену и низкий потолок. Это headless-исполнение, не визуальная проверка.

## Unity и Unreal

Собери пример в целевом редакторе/проекте и запиши версию. Проверь стену, потолок, лестницу/ступень, наклон и респавн. Для Unreal отдельно прогоняй UHT и полную сборку game module. C++ math test не доказывает корректность Unreal headers, а C# math test не доказывает сборку Unity component.

## Матрица игрового поведения

| Сценарий | Ожидание |
| --- | --- |
| Воздух, ввод 0 | Горизонтальный импульс сохраняется вне столкновений |
| Стрейф с поворотом | Скорость растёт по проекции, не мгновенно сбрасывается к run speed |
| Прямое нажатие при достигнутой проекции | Нет бесконечного разгона вперёд |
| 20 принятых прыжков на удержании | Прыжки повторяются, нет лишнего friction-step |
| Отпустить jump и движение | Приземление и остановка |
| Стена/потолок | Нет прохода сквозь геометрию и повторного ввода старого импульса в стену |
| Crouch под потолком | Нельзя встать в препятствие |
| Респавн/телепорт | Нет старого fall episode и ложного UPS от телепорта |
| 30/60/144 FPS | Нет множителя «разгон за кадр»; фиксированный physics replay сравним |
| Сервер и два клиента | Совпадающая симуляция, допустимые коррекции, управляемый replay |

При публикации статуса различай: math tested, engine compiled, headless runtime tested, visually tested, network tested. Не замещай одно другим.
