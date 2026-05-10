@tool
extends ActionLeaf

var finished_idle := false

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not actor.is_connected("idle_finished", _idle_finished):
		actor.connect("idle_finished", _idle_finished)
		actor.start_idle()

	if finished_idle:
		finished_idle = false
		actor.disconnect("idle_finished", _idle_finished)
		return SUCCESS
	else:
		return RUNNING
	
func _idle_finished() -> void:
	finished_idle = true
