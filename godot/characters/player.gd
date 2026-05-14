extends CharacterBody2D
class_name Player

@export var player_speed = 300.0
@onready var eating_prompt: Control = %EatPrompt
@onready var eating_qte: Control = $"Eating QTE"
@onready var QTE_animation: AnimationPlayer = %QTEAnimation
@onready var transformation_menu: Control = $TransformationSelection
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var Transform_effect: AnimatedSprite2D = $TransformEffect

@onready var transform_sfx: FmodEventEmitter2D = %Transform
@onready var minigame_start_sfx : FmodEventEmitter2D = %MinigameStart
@onready var minigame_success_stinger: FmodEventEmitter2D = %MinigameSuccess
@onready var minigame_fail_stinger: FmodEventEmitter2D = %MinigameFail
@onready var footsteps: FmodEventEmitter2D = %Steps

@onready var heavy_indicator: ColorRect = %HeavyIndicator
@onready var cursed_indicator: ColorRect = %CursedIndicator
@onready var locked_indicator: ColorRect = %LockedIndicator
@onready var magic_indicator: ColorRect = %MagicInidicator

var is_transformation_menu_open := false
var is_transformed := false
var is_moving := false
var prev_direction: Vector2 = Vector2.ZERO
var adventurer_to_eat: Adventurer

var ObjectType: Global.ObjectTypes

var step_timer := 0.0
const STEP_DELAY := 0.6

signal ate_adventurer
signal start_eating
signal stop_eating
signal damage_score

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_eat"):
		if eating_prompt.visible:
			trigger_minigame()
	
	if event.is_action_pressed("player_transform"):
		if is_transformed:
			is_transformed = false
			remove_from_group("object")
			Transform_effect.play("default")
			transform_sfx.play_one_shot()
			turn_off_indicator()
		elif is_transformation_menu_open:
			transformation_menu.close()
			is_transformation_menu_open = false
		else:
			transformation_menu.open()
			is_transformation_menu_open = true

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if Vector2.UP.angle_to(prev_direction) < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	if is_transformed:
		is_moving = false
		return

	if direction:
		prev_direction = direction
		velocity = direction * player_speed
		is_moving = true
		if step_timer <= 0:
			footsteps.play()
			step_timer = STEP_DELAY
		step_timer -= delta
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.y = move_toward(velocity.y, 0, player_speed)
		is_moving = false

	move_and_slide()

func _process(_delta: float) -> void:
	if is_moving:
		sprite.play("walk")
	elif is_transformed:
		sprite.play("transformed_idle")
	else:
		sprite.play("Idle")

func _on_eating_range_body_exited(_body: Node2D) -> void:
	adventurer_to_eat = null
	eating_prompt.visible = false

func _on_eating_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("adventurers"):
		adventurer_to_eat = body

	eating_prompt.visible = true

func trigger_minigame() -> void:
	start_eating.emit()
	get_tree().paused = true
	sprite.play("bite_start")
	minigame_start_sfx.play()
	is_transformed = false
	eating_prompt.visible = false
	remove_from_group("object")
	await sprite.animation_finished
	eating_qte.visible = true
	QTE_animation.play("eating_qte")
	
func eat_adventurer() -> void:
	eating_qte.visible = false
	QTE_animation.stop()
	var eat_value = adventurer_to_eat.value
	adventurer_to_eat.leave()
	adventurer_to_eat = null
	minigame_success_stinger.play()
	sprite.play("bite_success")
	await sprite.animation_finished
	get_tree().paused = false
	ate_adventurer.emit(eat_value)
	stop_eating.emit()

func fail_QTE() -> void:
	eating_qte.visible = false
	QTE_animation.stop()
	minigame_fail_stinger.play()
	sprite.play("bite_fail")
	await sprite.animation_finished
	get_tree().paused = false
	stop_eating.emit()
	adventurer_to_eat = null
	damage()

func damage() -> void:
	damage_score.emit()

func _on_eating_qte_time_up() -> void:
	fail_QTE()

func _on_transformation_selection(type: Global.ObjectTypes) -> void:
	Transform_effect.play("default")
	transform_sfx.play_one_shot()
	ObjectType = type
	turn_on_type_indicator(type)
	add_to_group("object")
	is_transformed = true
	is_transformation_menu_open = false

func turn_on_type_indicator(type: Global.ObjectTypes) -> void:
	match type:
		Global.ObjectTypes.HEAVY:
			heavy_indicator.visible = true
		Global.ObjectTypes.LOCKED:
			locked_indicator.visible = true
		Global.ObjectTypes.CURSED:
			cursed_indicator.visible = true
		Global.ObjectTypes.MAGICAL:
			magic_indicator.visible = true

func turn_off_indicator() -> void:
	heavy_indicator.visible = false
	locked_indicator.visible = false
	cursed_indicator.visible = false
	magic_indicator.visible = false
