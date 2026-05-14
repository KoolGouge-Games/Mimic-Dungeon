@tool
extends ActionLeaf

var finished_looting := false

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.is_connected("looting_finished", _looting_finished):
		actor.connect("looting_finished", _looting_finished)
		actor.loot_poi()

	if actor.feared:
		return FAILURE
	if finished_looting:
		finished_looting = false
		actor.disconnect("looting_finished", _looting_finished)
		return SUCCESS
	else:
		return RUNNING
	
func _looting_finished() -> void:
	finished_looting = true

func interrupt(actor: Node, blackboard: Blackboard) -> void:
	actor.interrupt_looting()
