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

func get_nearest_node_in_group(group, position):
	var nodes = get_tree().get_nodes_in_group(group)
	nodes.sort_custom( func(a,b): return a.global_position.distance_to(position)<b.global_position.distance_to(position) )
	return nodes[0]
