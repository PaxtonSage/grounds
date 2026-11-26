extends RigidBody2D

var dir:Vector2
var speed = 100

func _physics_process(delta: float) -> void:
	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	dir = dir.normalized()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
