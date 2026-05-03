extends Node2D

@onready var spawner: Marker2D = $NPCSpawner
@onready var music_player: FmodEventEmitter2D = $MusicPlayer

signal queue_adventurer

var npc_queue: Array[String]
var npc_scene := load("res://characters/Adventurer.tscn")

func queue_npc(type: Global.NPCTypes) -> void:
	queue_adventurer.emit(type)

func spawn_npc(type: Global.NPCTypes) -> void:
	var npc = npc_scene.instantiate()
	npc.initialize(type)
	npc.position = spawner.position
	add_child(npc)

	match type:
		Global.NPCTypes.KNIGHT:
			music_player.set_parameter("Knight-Active", true)
		Global.NPCTypes.ROGUE:
			music_player.set_parameter("Rogue Active", true)
		Global.NPCTypes.CLERIC:
			music_player.set_parameter("Cleric Active", true)
		Global.NPCTypes.MAGE:
			music_player.set_parameter("Mage Active", true)

func _on_button_pressed() -> void:
	queue_npc(Global.NPCTypes.KNIGHT)

