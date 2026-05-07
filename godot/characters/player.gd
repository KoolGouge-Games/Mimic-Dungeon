extends CharacterBody2D
class_name Player

@export var player_speed = 300.0
@onready var eating_prompt: Control = %EatPrompt
@onready var eating_qte: Control = $"Eating QTE"
@onready var QTE_animation: AnimationPlayer = %QTEAnimation
@onready var Transformation_menu: Control = $TransformationSelection
@onready var Trans_menu_animation: AnimationPlayer = %TransMenuAnimation

var eating_minigame := false
var is_arrow_over_green := false
var is_transformation_menu_open := false
var is_transformed := false
var is_moving := false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_eat"):
		if eating_minigame:
			if is_arrow_over_green:
				eat_adventurer()
			else:
				fail_QTE()

		elif eating_prompt.visible:
			trigger_minigame()
	
	if event.is_action_pressed("player_transform"):
		if is_transformed:
			is_transformed = false
			remove_from_group("object")
		elif is_transformation_menu_open:
			Trans_menu_animation.play_backwards("open")
			is_transformation_menu_open = false
		else:
			Trans_menu_animation.play("open")
			is_transformation_menu_open = true

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * player_speed
		is_moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.y = move_toward(velocity.y, 0, player_speed)
		is_moving = false

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

func _on_transformation_selection(type: Global.ObjectTypes) -> void:
	print("transform into a ", type, " object")
	add_to_group("object")
	is_transformed = true

