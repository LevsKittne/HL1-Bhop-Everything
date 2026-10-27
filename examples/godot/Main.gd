extends Node3D
const Player = preload("res://BhopPlayer.gd")

func add_box(where: Vector3, size: Vector3, color: Color) -> void:
    var body := StaticBody3D.new()
    body.position = where
    var shape := CollisionShape3D.new()
    var box := BoxShape3D.new()
    box.size = size
    shape.shape = box
    body.add_child(shape)
    var mesh := MeshInstance3D.new()
    var box_mesh := BoxMesh.new()
    box_mesh.size = size
    mesh.mesh = box_mesh
    var material := StandardMaterial3D.new()
    material.albedo_color = color
    mesh.material_override = material
    body.add_child(mesh)
    add_child(body)

func _ready() -> void:
    var actions: Dictionary = {"bhop_forward":KEY_W,"bhop_back":KEY_S,"bhop_left":KEY_A,"bhop_right":KEY_D,"bhop_jump":KEY_SPACE}
    for action in actions:
        if not InputMap.has_action(action):
            InputMap.add_action(action)
            var event := InputEventKey.new()
            event.physical_keycode = actions[action]
            InputMap.action_add_event(action,event)
    add_box(Vector3(0,-0.5,0),Vector3(200,1,200),Color(0.18,0.22,0.27))
    add_box(Vector3(8,1,-5),Vector3(2,2,12),Color(0.4,0.5,0.65))
    add_box(Vector3(-8,2.45,0),Vector3(4,0.6,4),Color(0.55,0.4,0.3))
    var light := DirectionalLight3D.new()
    light.rotation_degrees = Vector3(-55,-30,0)
    light.light_energy = 1.5
    add_child(light)
    var world := WorldEnvironment.new()
    world.environment = Environment.new()
    world.environment.background_mode = Environment.BG_COLOR
    world.environment.background_color = Color(0.15,0.2,0.3)
    world.environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
    world.environment.ambient_light_color = Color(0.6,0.65,0.75)
    world.environment.ambient_light_energy = 0.7
    add_child(world)
    var player := CharacterBody3D.new()
    player.set_script(Player)
    player.name = "Player"
    player.position = Vector3(0,1,0)
    add_child(player)
