extends Control

@onready var self_close_sfx: FmodEventEmitter2D = %SelfClose

var master_bus: FmodBus
var music_bus: FmodBus
var sfx_bus: FmodBus

func _ready() -> void:
	master_bus = FmodServer.get_bus("bus:/")
	music_bus = FmodServer.get_bus("bus:/MUSIC")
	sfx_bus = FmodServer.get_bus("bus:/SFX")
	master_bus.set_volume(1.0)
	music_bus.set_volume(1.0)
	sfx_bus.set_volume(1.0)

func _on_main_slider_value_changed(value: float) -> void:
	master_bus.set_volume(value)

func _on_music_slider_value_changed(value: float) -> void:
	music_bus.set_volume(value)

func _on_sfx_slider_value_changed(value: float) -> void:
	sfx_bus.set_volume(value)

func _on_exit_button_pressed() -> void:
	self_close_sfx.play_one_shot()
	self.visible = false

