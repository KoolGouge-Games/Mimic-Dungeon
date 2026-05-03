extends Area2D

var sprite: AnimatedSprite2D 

var stats: NPCStats

var speed := 5
var fear : int
var favored_object : Global.ObjectTypes

var move_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	add_to_group("adventurers")

func initialize(type: Global.NPCTypes) -> void:
	var resourcepath := "res://Resources/npcs/%s.tres"
	match type:
		Global.NPCTypes.KNIGHT:
			print("spawning knight")
			resourcepath = resourcepath % "Knight"
		Global.NPCTypes.ROGUE:
			print("spawning rogue")
			resourcepath = resourcepath % "Rogue"
		Global.NPCTypes.CLERIC:
			print("spawning cleric")
			resourcepath = resourcepath % "Cleric"
		Global.NPCTypes.MAGE:
			print("spawning mage")
			resourcepath = resourcepath % "Mage"

	stats = load(resourcepath)
	sprite = $AnimatedSprite2D

	speed = stats.Speed
	fear = stats.FearValue
	favored_object = stats.FavoredType
	sprite.set_sprite_frames(stats.SpriteSheet)

func _process(delta: float) -> void:
	position += move_direction * speed * delta
