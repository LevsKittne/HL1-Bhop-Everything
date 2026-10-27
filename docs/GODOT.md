# Godot 4

## Запустить готовую площадку

Открой examples/godot/project.godot в Godot 4. Запусти проект: WASD, мышь, удержание Space; Esc освобождает мышь, щелчок захватывает её снова. Сначала разбегись по земле, затем удерживай прыжок; для воздушного разгона используй A/D с поворотом. На площадке есть пол и препятствие. Внизу отображается горизонтальный UPS.

Пример содержит BhopCore.gd (чистая математика), BhopPlayer.gd (CharacterBody3D), Main.gd (площадка) и test-скрипты. Демо использует обычный физический шаг движка и собственные тестовые input actions.

## Перенести в существующую игру

1. Найди `_physics_process` своего персонажа и единственный `move_and_slide`/другой solve.
2. Сохрани ввод проекта. Получи camera-yaw-relative wish в XZ без вертикального pitch; ограничь диагональ, сохрани аналоговую длину.
3. Проверь grounded и возможность прыжка до горизонтального шага. Если прыжок принят, пропусти наземное трение и задай вертикальный импульс по текущим правилам.
4. Преобразуй velocity.x/z в GS units; вызови BhopCore.step; верни XZ обратно.
5. Обнови вертикальную гравитацию один раз и вызови `move_and_slide()`. В Godot 4 velocity измеряется в единицах/с — **не умножай velocity на delta перед move_and_slide**.
6. На следующем шаге используй обновлённый collision solver вектор. Не перезаписывай его старым cached velocity после стены.

`is_on_floor()` описывает результат последнего движения. `get_real_velocity()` учитывает фактическое перемещение, включая наклон; для HUD проецируй его на горизонтальную плоскость. [CharacterBody3D API](https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html).

## Пол и склон

Floor snap, floor_constant_speed, slope angles и platform velocity способны менять ощущение. В демо snap=0.15 и floor_constant_speed=true, но эти значения не переносимы во все игры. Убедись, что положительная скорость прыжка не притягивается к полу. Для Godot 3 нужен отдельный адаптер KinematicBody: у move_and_slide другой контракт, не меняй только имя класса.

## Проверить

```shell
godot --headless --path examples/godot --editor --import
godot --headless --path examples/godot --script res://test_math.gd
godot --headless --path examples/godot --script res://test_runtime.gd
```

Укажи путь к своему exe, если godot отсутствует в PATH. В export/PCK не всегда есть доступный изменяемый исходный скрипт: переходи к COMPILED-GAMES.md, а не обещай восстановление любого проекта.
