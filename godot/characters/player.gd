extends CharacterBody2D
class_name Player

@export var player_speed = 300.0
@onready var eating_prompt: Control = %EatPrompt
@onready var eating_qte: Control = $"Eating QTE"
@onready var QTE_animation: AnimationPlayer = %QTEAnimation
@onready var transformation_menu: Control = $TransformationSelection

var eating_minigame := false
var is_arrow_over_green := false
var is_transformation_menu_open := false
var is_transformed := false
var is_moving := false
var adventurer_to_eat: Adventurer

var ObjectType: Global.ObjectTypes

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
			transformation_menu.close()
			is_transformation_menu_open = false
		else:
			transformation_menu.open()
			is_transformation_menu_open = true

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if is_transformed:
		direction = Vector2.ZERO

	if direction:
		velocity = direction * player_speed
		is_moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.y = move_toward(velocity.y, 0, player_speed)
		is_moving = false

	move_and_slide()

func _on_eating_range_body_exited(_body: Node2D) -> void:
	# adventurer_to_eat = null
	eating_prompt.visible = false

func _on_eating_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("adventurers"):
		adventurer_to_eat = body

	eating_prompt.visible = true

func trigger_minigame() -> void:
	adventurer_to_eat.process_mode = Node.PROCESS_MODE_DISABLED
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
	damage()

func damage() -> void:
	print("ow!")

func reset_QTE() -> void:
	QTE_animation.stop()
	eating_qte.visible = false
	is_arrow_over_green = false
	eating_minigame = false
	adventurer_to_eat.process_mode = Node.PROCESS_MODE_INHERIT

func _on_eating_qte_in_the_green() -> void:
	is_arrow_over_green = true

func _on_eating_qte_exit_green() -> void:
	is_arrow_over_green = false

func _on_eating_qte_time_up() -> void:
	fail_QTE()

func _on_transformation_selection(type: Global.ObjectTypes) -> void:
	ObjectType = type
	add_to_group("object")
	is_transformed = true
