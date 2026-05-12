extends Node2D

@onready var NPCAlertUI: Control = %NPCAlert
@onready var LevelCompleteUI: Control = %LevelComplete
@onready var pause_menu: Control = %PauseMenu
@onready var quit_confirmation: Control = %QuitConfirmation
@onready var global_animations: AnimationPlayer = %GlobalAnimations

@onready var current_level := $Level_1

var is_paused := false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused:
			unpause()
		else:
			pause()

func pause() -> void:
	get_tree().paused = true
	pause_menu.visible = true
	global_animations.play("open_pause_menu")

func go_to_options() -> void:
	print("to do!")

func go_to_menu() -> void:
	print("to do!")

func open_quit_confirmation() -> void:
	print("confirming")
	quit_confirmation.visible = true

func close_quit_confirmation() -> void:
	quit_confirmation.visible = false

func unpause() -> void:
	get_tree().paused = false
	global_animations.play_backwards("open_pause_menu")
	pause_menu.visible = false
	close_quit_confirmation()

func _on_queue_adventurer(type: Global.NPCTypes) -> void:
	NPCAlertUI.startNPCTimer(3.0, type)

func _on_npc_alert_spawn_npc(type: Global.NPCTypes) -> void:
	current_level.spawn_npc(type)

func _on_player_won(_score: int) -> void:
	LevelCompleteUI.visible = true
	global_animations.play("show_winscree")
