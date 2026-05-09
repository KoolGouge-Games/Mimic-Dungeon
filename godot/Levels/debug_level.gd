extends Node2D

@onready var spawner: Marker2D = $NPCSpawner

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

func _on_button_pressed() -> void:
	queue_npc(Global.NPCTypes.KNIGHT)

