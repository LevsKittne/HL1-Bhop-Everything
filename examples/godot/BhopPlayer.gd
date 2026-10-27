extends CharacterBody3D
const Core = preload("res://BhopCore.gd")
@export var gs_units_per_world_unit: float = 40.0
@export var maxspeed_ups: float = 300.0
@export var gravity: float = 20.0
@export var jump_height: float = 0.75
@export var auto_jump: bool = true
@export var stock_bunny_limit: bool = false
var camera: Camera3D
var meter: Label
var pitch: float = 0.0

func _ready() -> void:
    var capsule := CapsuleShape3D.new()
    capsule.radius = 0.35
    capsule.height = 1.8
    var shape := CollisionShape3D.new()
    shape.shape = capsule
    add_child(shape)
    floor_snap_length = 0.15
    floor_constant_speed = true
    camera = Camera3D.new()
    camera.position.y = 0.7
    camera.current = true
    add_child(camera)
    var canvas := CanvasLayer.new()
    add_child(canvas)
    meter = Label.new()
    meter.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    meter.add_theme_color_override("font_color", Color(1.0,160.0/255.0,0.0))
    meter.add_theme_color_override("font_shadow_color", Color(0,0,0,0.75))
    meter.add_theme_constant_override("shadow_offset_x", 2)
    meter.add_theme_constant_override("shadow_offset_y", 2)
    canvas.add_child(meter)
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
        Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
    if event is InputEventMouseButton and event.pressed:
        Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
        rotate_y(-event.relative.x * 0.002)
        pitch = clampf(pitch - event.relative.y * 0.002, -1.55, 1.55)
        camera.rotation.x = pitch

func _physics_process(delta: float) -> void:
    var input: Vector2 = Input.get_vector("bhop_left","bhop_right","bhop_forward","bhop_back")
    var wish: Vector3 = global_transform.basis * Vector3(input.x,0.0,input.y)
    var grounded: bool = is_on_floor()
    var wants_jump: bool = Input.is_action_pressed("bhop_jump") if auto_jump else Input.is_action_just_pressed("bhop_jump")
    var jump: bool = grounded and wants_jump
    var scale: float = maxf(gs_units_per_world_unit,0.001)
    var next: Vector2 = Core.step(Vector2(velocity.x,velocity.z)*scale,
        Vector2(wish.x,wish.z)*maxspeed_ups,delta,maxspeed_ups,grounded,jump,stock_bunny_limit)
    velocity.x = next.x / scale
    velocity.z = next.y / scale
    if jump:
        velocity.y = sqrt(2.0*gravity*jump_height)
    elif grounded and velocity.y < 0.0:
        velocity.y = 0.0
    velocity.y -= gravity * delta
    move_and_slide()

func _process(_delta: float) -> void:
    var viewport_size: Vector2 = get_viewport().get_visible_rect().size
    var font_size: int = clampi(int(viewport_size.y/300.0),2,8)*20
    meter.add_theme_font_size_override("font_size",font_size)
    meter.size = Vector2(viewport_size.x,font_size+16)
    meter.position = Vector2(0,viewport_size.y-font_size-30)
    var real: Vector3 = get_real_velocity()
    meter.text = str(clampi(int(Vector2(real.x,real.z).length()*gs_units_per_world_unit),0,999999))
