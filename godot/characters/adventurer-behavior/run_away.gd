@tool
extends ActionLeaf

var reached_destination := false

func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor.is_connected("target_reached", _target_reached):
		actor.connect("target_reached", _target_reached)

	if !actor.feared:
		blackboard.set_value("POIChoice", null)
		return FAILURE
	elif reached_destination:
		reached_destination = false
		blackboard.set_value("POIChoice", null)
		actor.disconnect("target_reached", _target_reached)
		actor.is_walking = false
		return SUCCESS
	else:
		actor.is_walking = true
		return RUNNING

func _target_reached():
	reached_destination = true

func interrupt(actor: Node, blackboard: Blackboard) -> void:
	reached_destination = false
	blackboard.set_value("POIChoice", null)
	actor.disconnect("target_reached", _target_reached)
	actor.navigation.set_target_position(actor.position)
	actor.is_walking = false
	actor.feared = false
