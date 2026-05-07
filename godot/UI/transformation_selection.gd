extends Control

signal transform

func _on_basic_pressed() -> void:
	transform.emit(Global.ObjectTypes.BASIC)

func _on_magical_pressed() -> void:
	transform.emit(Global.ObjectTypes.MAGICAL)

func _on_cursed_pressed() -> void:
	transform.emit(Global.ObjectTypes.CURSED)

func _on_locked_pressed() -> void:
	transform.emit(Global.ObjectTypes.LOCKED)

func _on_heavy_pressed() -> void:
	transform.emit(Global.ObjectTypes.HEAVY)

