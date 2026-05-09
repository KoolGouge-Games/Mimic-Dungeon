extends Node

enum ObjectTypes {
	BASIC,
	HEAVY,
	LOCKED,
	CURSED,
	MAGICAL
	}

enum NPCTypes {
	KNIGHT,
	ROGUE,
	CLERIC,
	MAGE
	}

var rngsus := RandomNumberGenerator.new()
const FAVORED_BONUS := 2
const BASE_LOOTING_TIME := 10

func get_group_sorted_by_distance(group: String, position: Vector2) -> Array[Node]:
	var nodes := get_tree().get_nodes_in_group(group)
	nodes.sort_custom( func(a,b): return a.global_position.distance_to(position)<b.global_position.distance_to(position) )
	return nodes

func get_nearest_node_in_group(group: String, position: Vector2) -> Node:
	var sortedList := get_group_sorted_by_distance(group, position)
	return sortedList[0]
