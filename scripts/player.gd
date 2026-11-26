extends CharacterBody2D

var dir:Vector2 
var x_speed = 20
var y_speed = 10
var jumpForce = 2000
var acceleration:Vector2

var gravity = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	dir = dir.normalized()		#Only neccesary when dir.y is being taken account of

func _physics_process(delta: float) -> void:	
	acceleration = Vector2.ZERO
	
	acceleration.x += dir.x * x_speed
	acceleration.y += dir.y * y_speed
	
	if Input.is_action_just_pressed("jump"):
		acceleration.y = -jumpForce
		
	acceleration.y += gravity
	
	
	velocity.x += acceleration.x * delta
	velocity.y += acceleration.y * delta
	
	move_and_slide()
