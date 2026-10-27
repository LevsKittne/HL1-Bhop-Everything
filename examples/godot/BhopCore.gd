extends RefCounted

# GoldSrc units, two horizontal axes; no collision or vertical integration.
static func step(v: Vector2, wish: Vector2, dt: float, maxspeed: float = 300.0,
        grounded: bool = false, jump: bool = false, stock: bool = true,
        surface: float = 1.0, edge: float = 1.0) -> Vector2:
    if dt <= 0.0:
        return v
    var wish_length: float = wish.length()
    var w: float = minf(wish_length, maxspeed)
    var air: bool = not grounded or jump
    if grounded and jump and stock:
        var limit: float = 1.7 * maxspeed
        var speed: float = v.length()
        if limit > 0.0 and speed > limit:
            v *= limit / speed * 0.65
    if not air:
        var speed: float = v.length()
        if speed >= 0.1:
            var drop: float = maxf(speed, 100.0) * 4.0 * dt * surface * edge
            v *= maxf(speed - drop, 0.0) / speed
    if wish_length > 0.0:
        var direction: Vector2 = wish / wish_length
        var cap: float = minf(w, 30.0) if air else w
        var add: float = cap - v.dot(direction)
        if add > 0.0:
            v += direction * minf(add, 10.0 * w * dt * surface)
    if not air and v.length() < 1.0:
        return Vector2.ZERO
    return v
