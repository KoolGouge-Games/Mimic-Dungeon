@tool
extends ActionLeaf

var reached_destination := false

func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor.is_connected("target_reached", _target_reached):
		actor.connect("target_reached", _target_reached)

	if actor.chosen_poi == null:
		blackboard.set_value("POIChoice", null)
		return FAILURE
	elif reached_destination:
		reached_destination = false
		blackboard.set_value("POIChoice", null)
		actor.disconnect("target_reached", _target_reached)
		return SUCCESS
	else:
		return RUNNING

func _target_reached():
	reached_destination = true

func interrupt(actor: Node, blackboard: Blackboard) -> void:
	print("interrupted!")
	actor.chosen_poi = null
	blackboard.set_value("POIChoice", null)
