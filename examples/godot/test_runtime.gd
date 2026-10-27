extends SceneTree
func _initialize() -> void:
    call_deferred("run_test")

func require(condition: bool, message: String) -> bool:
    if condition:
        return true
    push_error(message)
    quit(1)
    return false

func run_test() -> void:
    var scene: Node = load("res://Main.tscn").instantiate()
    root.add_child(scene)
    for frame in range(90):
        await physics_frame
    var player: CharacterBody3D = scene.get_node("Player")
    if not require(player.is_on_floor(),"Player did not settle on the floor"):
        return
    var start: Vector3 = player.global_position
    Input.action_press("bhop_forward")
    # Run up on the ground first. A straight airborne start from rest is capped
    # to 30 GS units of forward projection; gaining more requires strafing.
    for frame in range(60):
        await physics_frame
    if not require(Vector2(player.velocity.x,player.velocity.z).length()*40.0 > 200.0,"Ground acceleration failed"):
        return
    Input.action_press("bhop_jump")
    var takeoffs: int = 0
    var previous_vertical: float = 0.0
    var max_ups: float = 0.0
    for frame in range(240):
        await physics_frame
        if player.velocity.y > 0.0 and previous_vertical <= 0.0:
            takeoffs += 1
        previous_vertical = player.velocity.y
        max_ups = maxf(max_ups,Vector2(player.velocity.x,player.velocity.z).length()*40.0)
        if not require(player.global_position.y > -1.0,"Player fell through the floor"):
            return
    Input.action_release("bhop_forward")
    Input.action_release("bhop_jump")
    if not require(takeoffs >= 3,"Held jump failed to repeat: " + str(takeoffs)):
        return
    if not require(player.global_position.distance_to(start)>2.0 and max_ups>100.0,"Player did not gain horizontal movement"):
        return
    for frame in range(180):
        await physics_frame
    if not require(player.is_on_floor(),"Player did not land after releasing jump"):
        return
    if not require(Vector2(player.velocity.x,player.velocity.z).length()*40.0 < 1.0,"Player did not stop after releasing input"):
        return
    var meter: Label = player.get("meter")
    if not require(meter != null and not meter.text.is_empty(),"HUD missing"):
        return
    # Approach the wall from the left and retain collision-corrected X speed.
    player.global_position = Vector3(0,1,-5)
    player.velocity = Vector3.ZERO
    for frame in range(60):
        await physics_frame
    Input.action_press("bhop_right")
    for frame in range(120):
        await physics_frame
    Input.action_release("bhop_right")
    if not require(player.global_position.x > 6.0 and player.global_position.x < 6.8,"Wall collision did not constrain the capsule"):
        return
    if not require(absf(player.velocity.x)<0.05,"Wall-constrained horizontal velocity was not retained"):
        return
    player.global_position = Vector3(-8,1,0)
    player.velocity = Vector3.ZERO
    for frame in range(60):
        await physics_frame
    Input.action_press("bhop_jump")
    var peak: float = player.global_position.y
    for frame in range(120):
        await physics_frame
        peak = maxf(peak,player.global_position.y)
    Input.action_release("bhop_jump")
    if not require(peak < 1.3,"Jump passed through the low ceiling"):
        return
    print("PASS Godot runtime: floor, horizontal movement, ",takeoffs," held-jump takeoffs, landing, stop, HUD, wall, ceiling; max UPS ",max_ups)
    scene.queue_free()
    await process_frame
    quit(0)
