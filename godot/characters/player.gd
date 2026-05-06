extends CharacterBody2D

@export var player_speed = 300.0
@onready var eating_prompt: Control = %EatPrompt
@onready var eating_qte: Control = $"Eating QTE"
@onready var QTE_animation: AnimationPlayer = %QTEAnimation

var eating_minigame := false
var is_arrow_over_green := false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_eat"):
		if eating_minigame:
			if is_arrow_over_green:
				eat_adventurer()
			else:
				fail_QTE()

		elif eating_prompt.visible:
			trigger_minigame()
	

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.y = move_toward(velocity.y, 0, player_speed)

	move_and_slide()

func _on_eating_range_body_exited(_body: Node2D) -> void:
	eating_prompt.visible = false


func _on_eating_range_body_entered(_body: Node2D) -> void:
	eating_prompt.visible = true

func trigger_minigame() -> void:
	eating_prompt.visible = false
	eating_minigame = true
	eating_qte.visible = true
	QTE_animation.play("eating_qte")
	
func eat_adventurer() -> void:
	print("om nom nom")
	reset_QTE()

func fail_QTE() -> void:
	print("oh no!")
	reset_QTE()

func reset_QTE() -> void:
	QTE_animation.stop()
	eating_qte.visible = false
	is_arrow_over_green = false
	eating_minigame = false

func _on_eating_qte_in_the_green() -> void:
	is_arrow_over_green = true

func _on_eating_qte_exit_green() -> void:
	is_arrow_over_green = false

func _on_eating_qte_time_up() -> void:
	fail_QTE()

