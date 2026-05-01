extends CharacterBody2D


@export var player_speed = 300.0

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.y = move_toward(velocity.y, 0, player_speed)

	move_and_slide()
