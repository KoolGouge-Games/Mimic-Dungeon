extends Node
class_name Level_Script

@export var max_adventurers := 3
@export var max_score := 12

@onready var spawner: Marker2D = $NPCSpawner
@onready var music_player: FmodEventEmitter2D = $MusicPlayer
@onready var score_display: Label = %ScoreDisplay

signal queue_adventurer

var npc_queue: Array[String]
var npc_scene := load("res://characters/Adventurer.tscn")

var player_score = 0
var current_adventurers := 0

signal player_won

func _ready() -> void:
	score_display.text = str("0/", max_score)

func queue_npc(type: Global.NPCTypes) -> void:
	queue_adventurer.emit(type)

func spawn_npc(type: Global.NPCTypes) -> void:
	var npc = npc_scene.instantiate()
	npc.initialize(type)
	npc.position = spawner.position
	add_child(npc)

	match type:
		Global.NPCTypes.KNIGHT:
			music_player.set_parameter("knight-active", true)
		Global.NPCTypes.ROGUE:
			music_player.set_parameter("rogue-active", true)
		Global.NPCTypes.CLERIC:
			music_player.set_parameter("cleric-active", true)
		Global.NPCTypes.MAGE:
			music_player.set_parameter("Mage-Active", true)
	
	npc.connect("adventurer_left", _on_adventurer_left)
	current_adventurers += 1

func _on_adventurer_timer_timeout() -> void:
	if current_adventurers < max_adventurers:
		queue_npc(Global.NPCTypes.values().pick_random())
	else: 
		print("too many adventurers!")

func _on_adventurer_left(type: Global.NPCTypes) -> void:
	print("adventurer left")
	current_adventurers -= 1
	match type:
		Global.NPCTypes.KNIGHT:
			music_player.set_parameter("knight-active", false)
		Global.NPCTypes.ROGUE:
			music_player.set_parameter("rogue-active", false)
		Global.NPCTypes.CLERIC:
			music_player.set_parameter("cleric-active", false)
		Global.NPCTypes.MAGE:
			music_player.set_parameter("Mage-Active", false)


func _on_player_ate_adventurer(value: int) -> void:
	player_score += value
	score_display.text = str(player_score, "/", max_score)

	if player_score >= max_score:
		player_won.emit(player_score)
