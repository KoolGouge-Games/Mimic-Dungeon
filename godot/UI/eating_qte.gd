extends Control

signal fail
signal succeed

var is_in_green := false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_eat"):
			if is_in_green:
				succeed.emit()
			else:
				fail.emit()

func green() -> void:
	is_in_green = true

func red() -> void:
	is_in_green = false

func finish() -> void:
	fail.emit()
