extends Control

@onready var Trans_menu_animation: AnimationPlayer = %TransMenuAnimation

signal transform

func _on_basic_pressed() -> void:
	transform.emit(Global.ObjectTypes.BASIC)
	close()

func _on_magical_pressed() -> void:
	transform.emit(Global.ObjectTypes.MAGICAL)
	close()

func _on_cursed_pressed() -> void:
	transform.emit(Global.ObjectTypes.CURSED)
	close()

func _on_locked_pressed() -> void:
	transform.emit(Global.ObjectTypes.LOCKED)
	close()

func _on_heavy_pressed() -> void:
	transform.emit(Global.ObjectTypes.HEAVY)
	close()

func close() -> void:
	Trans_menu_animation.play_backwards("open")

func open() -> void:
	Trans_menu_animation.play("open")
