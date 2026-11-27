extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		global_position = $"../CharacterBody2D".anchor
	else:
		global_position = $"../CharacterBody2D/RayCast2D".get_collision_point()
