extends SceneTree
const Core = preload("res://BhopCore.gd")
func _initialize() -> void:
    var path: String = ProjectSettings.globalize_path("res://").path_join("../../tests/cases.csv").simplify_path()
    var file := FileAccess.open(path,FileAccess.READ)
    if file == null:
        push_error("Missing fixture file: " + path)
        quit(2)
        return
    file.get_csv_line()
    var count: int = 0
    var largest: float = 0.0
    while not file.eof_reached():
        var c: PackedStringArray = file.get_csv_line()
        if c.size() == 1 and c[0].is_empty():
            continue
        if c.size() != 14:
            push_error("Bad fixture row")
            quit(2)
            return
        var v: Vector2 = Core.step(Vector2(c[1].to_float(),c[2].to_float()),
            Vector2(c[3].to_float(),c[4].to_float()),c[5].to_float(),c[6].to_float(),
            c[7].to_int()!=0,c[8].to_int()!=0,c[9].to_int()!=0,c[10].to_float(),c[11].to_float())
        var error: float = maxf(absf(v.x-c[12].to_float()),absf(v.y-c[13].to_float()))
        largest = maxf(largest,error)
        if error > 0.002:
            push_error(c[0] + ": error " + str(error))
            quit(1)
            return
        count += 1
    print("PASS GDScript: ",count," fixtures, largest error ",largest," GS units/s")
    quit(0 if count > 0 else 2)
