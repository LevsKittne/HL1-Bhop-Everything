# Другие 3D-движки и собственный контроллер

Любому движку нужны одни входы: фактическая скорость, wish, dt, ground/jump eligibility, up axis, scale и collision solver. Если они доступны, чистая математика переносится независимо от рендера. Если controller закрыт, сначала нужен доступ к нему.

| Система | Где начать | Ошибка, которую проверить |
| --- | --- | --- |
| Stride | CharacterComponent, IsGrounded, LinearVelocity, SetVelocity | SetVelocity принимает скорость; не умножать на dt второй раз |
| O3DE | Physics::Character, velocity requests/character controller | Не смешивать накопленные AddVelocity requests с абсолютной скоростью |
| CryEngine | Player component и character controller текущей версии | Заменить запись direction*speed сохранённым импульсом, учесть встроенную инерцию |
| Source / idTech | Исходный shared movement / PM_* конкретной игры | Модификации формул и caps отличаются между играми |
| Собственный C++ движок | UpdateCharacter/PhysicsStep/MoveAndSlide | Найти единственный владелец скорости и порядок коллизий |
| ECS / сторонний physics character | Система управления персонажем, scheduling | Использовать её fixed step и grounding, а не отдельный frame loop |

Первичные справки: [Stride CharacterComponent](https://doc.stride3d.net/latest/en/api/Stride.Physics.CharacterComponent.html), [O3DE Physics::Character](https://docs.o3de.org/docs/api/frameworks/azframework/class_physics_1_1_character.html), [CryEngine player component](https://www.cryengine.com/docs/static/engines/cryengine-5/categories/23756816/pages/101679110).

## Контракт адаптера

```
read input -> yaw-relative wish -> normalize only above magnitude 1
read velocity from the collision/movement owner
resolve accepted jump from game's rules
project velocity/wish onto plane perpendicular to up
convert to GS units
run core once for this simulation substep
convert back and preserve independent vertical component
apply the engine's vertical/jump rules once
solve collision through engine's movement API
store corrected velocity and ground contact for the next step
```

При произвольной гравитации выбери два ортонормальных вектора плоскости и ось up. Используй dot для преобразования 3D↔2D. Прямое обнуление Y неверно для движка с Z-up или вращающейся гравитацией.

При разработке нового адаптера сперва прогони cases.csv без коллизий, затем тестовую площадку: ровный пол, стена, наклон, край, ступень, потолок. Запиши, какие поведения реализованы и какие остаются движковыми. Чужое название engine не является основанием обещать готовую поддержку всех его игр.
