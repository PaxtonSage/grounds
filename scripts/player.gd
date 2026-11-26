extends CharacterBody2D

var dir:Vector2 
var speed = 200
var jumpForce = 100;

func _physics_process(delta: float) -> void:
	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	dir = dir.normalized()		#Only neccesary when dir.y is being taken account of
	
	velocity.x = dir.x * speed * delta
	if Input.is_action_just_pressed("jump"):	
		velocity.y = velocity.y + jumpForce
		
	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
