extends CharacterBody2D
class_name Adventurer

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var vision: VisionCone2D = $VisionCone2D
@onready var original_color = visionCone.color
@onready var loot_timer: Timer = $LootTimer
@onready var looting_clock: TextureProgressBar = %LootingClock
@onready var adventure_timer: Timer = $AdventureTimer
@onready var adventure_clock: TextureProgressBar = %AdventureClock
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var visionCone: Polygon2D
@export var alertColor: Color
@export var CLOSEST_NUM_CHOICES: int = 3
@export var movement_speed: int

@export var FAVORED_BONUS := 2
@export var BASE_LOOTING_TIME := 10

@export var ADV_MIN: float = 69.0 
@export var ADV_MAX: float = 120.0

var sprite: AnimatedSprite2D 
var stats: NPCStats

var nearest_poi: Area2D

var speed := 5
var feared := false
var idling := true
var favored_object : Global.ObjectTypes
var npc_type: Global.NPCTypes
var move_direction: Vector2 = Vector2.ZERO
var LOS_to_player := false
var value := 1
var is_walking = false

var chosen_poi: Node:
	get:
		return chosen_poi
	set(value):
		if navigation != null and value != null:
			navigation.set_target_position(value.position)
		chosen_poi = value

signal idle_finished
signal looting_finished
signal target_reached
signal adventurer_left

func _ready() -> void:
	var adventure_time := Global.rngsus.randf_range(ADV_MIN, ADV_MAX)
	adventure_clock.max_value = adventure_time
	adventure_clock.value = adventure_time
	adventure_timer.start(adventure_time)

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
	sprite = %AdventureSprite

	npc_type = stats.type
	speed = stats.Speed
	movement_speed = stats.Speed * 20
	favored_object = stats.FavoredType
	sprite.set_sprite_frames(stats.SpriteSheet)

func _process(_delta: float) -> void:
	adventure_clock.value = adventure_timer.time_left
	if looting_clock.visible:
		looting_clock.value = loot_timer.time_left

	if is_walking:
		sprite.play("walk")

func _physics_process(_delta: float) -> void:
	var next_path_point: Vector2 = navigation.get_next_path_position()
	var direction = global_position.direction_to(next_path_point)
	var new_velocity = direction * movement_speed

	if navigation.avoidance_enabled:
		navigation.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)
	velocity = new_velocity

	if not idling:
		vision.look_at(next_path_point)
		vision.rotate(deg_to_rad(-90.0))

		if Vector2.UP.angle_to(velocity) < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

func choosePOI() -> Node:
	var pois := Global.get_group_sorted_by_distance("object", self.position)

	if pois.size() < 1:
		leave()
		return

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
	print("looting")
	chosen_poi.remove_from_group("object")
	var looting_time := BASE_LOOTING_TIME - stats.Speed
	if chosen_poi.ObjectType == favored_object:
		looting_time -= FAVORED_BONUS

	looting_clock.max_value = looting_time
	looting_clock.value = looting_time

	looting_clock.visible = true

	loot_timer.start(looting_time)

func resolveFear() -> void:
	print("A mimic!")
	var time_left = adventure_timer.time_left
	adventure_timer.start(time_left - 1.0)
	feared = true
	navigation.set_target_position(position)

func leave() -> void:
	adventurer_left.emit(npc_type)
	queue_free()

func _on_vision_cone_area_body_entered(_body: Node2D) -> void:
	visionCone.color = alertColor
	LOS_to_player = true

func _on_vision_cone_area_body_exited(_body: Node2D) -> void:
	visionCone.color = original_color
	LOS_to_player = false

func _on_navigation_agent_2d_navigation_finished() -> void:
	if feared:
		feared = false
	else:
		emit_signal("target_reached")

func _on_loot_timer_timeout() -> void:
	looting_clock.visible = false

	if chosen_poi.is_in_group("player"):
		resolveFear()
		chosen_poi.damage()
	else:
		value += 1

	emit_signal("looting_finished")
	chosen_poi.start_respawn()
	
func start_idle() -> void:
	idling = true
	sprite.play("idle")
	animation_player.play("look_around")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	sprite.play("start_walk")
	await sprite.animation_finished

	idling = false
	if anim_name == "look_around":
		emit_signal("idle_finished")
	
