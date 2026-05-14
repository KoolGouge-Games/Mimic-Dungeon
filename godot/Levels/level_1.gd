extends Node
# class_name Level_Script

@export var max_adventurers := 3
@export var max_score := 12
@export var SCORE_PENALTY := 1

@onready var spawner: Marker2D = $NPCSpawner
@onready var music_player: FmodEventEmitter2D = $MusicPlayer
@onready var npc_spawn_sfx: FmodEventEmitter2D = $NPCSpawned
@onready var score_display: Label = %ScoreDisplay
@onready var camera_animation: AnimationPlayer = $CameraAnimation

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
	npc_spawn_sfx.play_one_shot()

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

func _on_adventurer_left(type: Global.NPCTypes) -> void:
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

func _on_player_start_eating() -> void:
	music_player.paused = true
	camera_animation.play("zoom")

func _on_player_stop_eating() -> void:
	camera_animation.play_backwards("zoom")

func on_pause() -> void:
	music_player.set_parameter("PauseParam", "PausedParam")

func on_unpause() -> void:
	music_player.set_parameter("PauseParam", "UnpausedParam")

func _on_player_damage_score() -> void:
	var new_score = player_score - SCORE_PENALTY
	if new_score < 0:
		new_score = 0

	player_score = new_score
	score_display.text = str(player_score, "/", max_score)

func cut_music() -> void:
	music_player.stop()
