extends Control

@onready var quit_confirmation: Control = %QuitConfirmation
@onready var how_to_play: Control = $HowToPlay
@onready var options_menu: Control = $OptionsMenu
@onready var open_menu_sfx: FmodEventEmitter2D = %OpenMenu

func _on_start_button_pressed() -> void:
	how_to_play.visible = true
	open_menu_sfx.play_one_shot()

func _on_option_button_pressed() -> void:
	options_menu.visible = true
	open_menu_sfx.play_one_shot()

func _on_quit_button_pressed() -> void:
	quit_confirmation.visible = true

func _on_yes_quit_button_pressed() -> void:
	get_tree().quit()

