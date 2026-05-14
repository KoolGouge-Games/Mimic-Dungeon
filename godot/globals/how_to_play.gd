extends Control

@onready var page_1: Control = %Page1
@onready var page_2: Control = %Page2

@onready var page_fwd_sfx: FmodEventEmitter2D = %PageFwd
@onready var page_bck_sfx: FmodEventEmitter2D = %PageBck
@onready var start_game: FmodEventEmitter2D = %GameStart

@onready var animations: AnimationPlayer = $AnimationPlayer

func _on_back_button_pressed() -> void:
	self.visible = false
	page_bck_sfx.play_one_shot()

func _on_next_page_button_pressed() -> void:
	page_1.visible = false
	page_2.visible = true
	page_fwd_sfx.play_one_shot()

func _on_prev_page_button_pressed() -> void:
	page_1.visible = true
	page_2.visible = false
	page_bck_sfx.play_one_shot()

func _on_start_button_pressed() -> void:
	start_game.play_one_shot()
	animations.play("fade_to_black")
	await animations.animation_finished
	SceneTransition.load_scene("res://globals/world.tscn")
