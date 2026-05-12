extends Node2D
class_name Interactable

@export var ObjectType: Global.ObjectTypes = Global.ObjectTypes.BASIC

@onready var sprite: Sprite2D = $Sprite2D
@onready var respawn_timer: Timer = $RespawnTimer
@onready var respawn_clock: TextureProgressBar = %RespawnClock

func _ready() -> void:
	choose_texture()

func _process(_delta: float) -> void:
	if respawn_clock.visible:
		respawn_clock.value = respawn_timer.time_left

func choose_texture() -> void:
	var texture_path := "res://assets/objects/%s.png"

	match ObjectType:
		Global.ObjectTypes.HEAVY:
			texture_path = texture_path % "Heavy"
		Global.ObjectTypes.LOCKED:
			texture_path = texture_path % "Locked"
		Global.ObjectTypes.CURSED:
			texture_path = texture_path % "Cursed"
		Global.ObjectTypes.MAGICAL:
			texture_path = texture_path % "Magic"
		Global.ObjectTypes.BASIC:
			texture_path = texture_path % "Basic"

	sprite.texture = load(texture_path)

func start_respawn():
	respawn_timer.start()
	respawn_clock.visible = true
	sprite.texture = null


func _on_respawn_timer_timeout() -> void:
	respawn_clock.visible = false
	choose_texture()
