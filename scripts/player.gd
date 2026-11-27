extends CharacterBody2D # gives us access to characterbody functions

const r = 32.0 # pixels to meters
var friction = 0.98
var gravity = 15.0 * r # gravity
var air = .98 # air resistance
var dir:Vector2 # (x, y)
var acceleration:Vector2 # (x, y)
var xAccelerationForce = 20.0 * r
var	yAccelerationForce = 3.0 * r
var jumpForce = 500 * r
var jumpVector:Vector2 = Vector2(0, 1) # instantaneous acceleration value for jump
var coyoteTime = 5
var timer = 0

var canJump = false
var canDoubleJump = false

enum jumpType {
	floor = 0,
	wall, 
	double, 
	head,
	coyote
}  
var jump

func _ready() -> void:
	pass # Replace with function body.
	
func _process(_delta: float) -> void:
	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	dir = dir.normalized()		#Only neccesary when dir.y is being taken account of

func _physics_process(delta: float) -> void:
	
	canJump = false
	if timer > 0:
		timer -= delta
		canJump = true
		jump = jumpType.coyote
	
	if is_on_floor():
		timer = coyoteTime
		canJump = true
		jump = jumpType.floor
		jumpVector = Vector2.UP
		
	if is_on_wall():
		timer = coyoteTime
		canJump = true
		jump = jumpType.wall
		if dir == Vector2.ZERO:
			jumpVector = get_wall_normal() + Vector2.UP
			#jumpVector = Vector2.UP
		else:
			#jumpVector = (Vector2.UP + dir)/2
			jumpVector = get_wall_normal() + Vector2.UP

		
	
	acceleration = Vector2.ZERO
	
	acceleration.x += dir.x * xAccelerationForce
	acceleration.y += dir.y * yAccelerationForce
		
	acceleration.y += gravity
	
	if Input.is_action_just_pressed("jump") and canJump:
		canJump = false
		timer = 0
		acceleration += jumpVector * jumpForce
		velocity.y *= 0
		if jump == jumpType.double:
			canDoubleJump = false
	
	velocity.x += (acceleration.x) * delta
	velocity.y += (acceleration.y) * delta
	velocity *= air
	
	if is_on_floor():
		velocity.x *= friction
	
	
	#print("x velocity:", velocity.x/r, "m/s, y velocity:", velocity.y/r, "m/s")
	
	
	move_and_slide()
