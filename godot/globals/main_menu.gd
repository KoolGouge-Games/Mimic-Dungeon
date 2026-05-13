extends Control

@onready var quit_confirmation: Control = %QuitConfirmation

func _on_start_button_pressed() -> void:
	SceneTransition.load_scene("res://globals/world.tscn")

func _on_option_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	quit_confirmation.visible = true

func _on_yes_quit_button_pressed() -> void:
	get_tree().quit()

