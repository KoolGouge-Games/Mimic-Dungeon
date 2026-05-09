@tool
extends ActionLeaf

var finished_looting := false

func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.loot_poi()

	if not actor.is_connected("looting_finished", _looting_finished):
		actor.connect("looting_finished", _looting_finished)

	if finished_looting:
		finished_looting = false
		actor.chosen_poi.lootable = false
		actor.value += 1
		actor.disconnect("looting_finished", _looting_finished)
		return SUCCESS
	else:
		return RUNNING
	
func _looting_finished() -> void:
	finished_looting = true
