extends CharacterBody2D
class_name Adventurer

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var vision: VisionCone2D = $VisionCone2D
@onready var original_color = visionCone.color
@onready var loot_timer: Timer = $LootTimer

@export var visionCone: Polygon2D
@export var alertColor: Color
@export var CLOSEST_NUM_CHOICES: int = 3
@export var movement_speed: int

var sprite: AnimatedSprite2D 
var stats: NPCStats

var nearest_poi: Area2D

var speed := 5
var fear : int
var favored_object : Global.ObjectTypes

var move_direction: Vector2 = Vector2.ZERO
var LOS_to_player := false
var value := 1

var chosen_poi: Node:
	get:
		return chosen_poi
	set(value):
		if navigation != null:
			navigation.set_target_position(value.position)
		return value

signal looting_finished
signal target_reached

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
	movement_speed = stats.Speed * 100
	fear = stats.FearValue
	favored_object = stats.FavoredType
	sprite.set_sprite_frames(stats.SpriteSheet)

func _physics_process(_delta: float) -> void:

	var next_path_point: Vector2 = navigation.get_next_path_position()
	var direction = global_position.direction_to(next_path_point)
	var new_velocity = direction * movement_speed

	if navigation.avoidance_enabled:
		navigation.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)
	velocity = new_velocity

	vision.look_at(direction)
	# 90 degrees
	vision.rotate(-1.5707963)

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

func choosePOI() -> Node:
	var pois := Global.get_group_sorted_by_distance("object", self.position)
	var choiceTable: Array[float] = []

	for i in range(CLOSEST_NUM_CHOICES):
		choiceTable.append(0.0)
		if pois.size() < (i + 1):
			continue
		elif pois[i].ObjectType == favored_object:
			choiceTable[i] = 2.0
		else:
			choiceTable[i] = 1.0

	var choice := pois[Global.rngsus.rand_weighted(choiceTable)]
	chosen_poi = choice
	return choice

func loot_poi() -> void:
	if chosen_poi.ObjectType == favored_object:
		loot_timer.start(Global.BASE_LOOTING_TIME - (stats.Speed + Global.FAVORED_BONUS))
	else:
		loot_timer.star(Global.BASE_LOOTING_TIME - stats.Speed)

func resolveFear() -> void:
	print("fear!")

func _on_vision_cone_area_body_entered(_body: Node2D) -> void:
	visionCone.color = alertColor
	LOS_to_player = true

func _on_vision_cone_area_body_exited(_body: Node2D) -> void:
	visionCone.color = original_color
	LOS_to_player = false

func _on_navigation_agent_2d_navigation_finished() -> void:
	emit_signal("target_reached")

func _on_loot_timer_timeout() -> void:
	emit_signal("looting_finished")
