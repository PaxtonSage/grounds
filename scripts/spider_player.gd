extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var attached := false
var anchor := Vector2.ZERO
var web_length := 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if not attached:
		var direction := Input.get_axis("left", "right")
		if direction and is_on_floor() or is_on_wall():
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	if attached:
		var to_player := anchor.direction_to(global_position)
		var distance := global_position.distance_to(anchor)
		if distance > web_length:
			var out_speed := velocity.dot(to_player)
			if out_speed > 0:
				velocity -= to_player * out_speed
			global_position = anchor + to_player * web_length
				
	move_and_slide()
	
	$RayCast2D.target_position = get_local_mouse_position()
	
	$RayCast2D.force_raycast_update()
	
	if Input.is_action_just_pressed("shoot") and $RayCast2D.is_colliding():
		attached = true
		anchor = $RayCast2D.get_collision_point()
		web_length = global_position.distance_to(anchor)
		print("yo im attached")
		
	if Input.is_action_just_released("shoot"):
		attached = false
		print("let go ig")
		
