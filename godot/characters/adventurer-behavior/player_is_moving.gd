@tool
extends ConditionLeaf

func tick(_actor: Node, blackboard: Blackboard) -> int:
	var player = blackboard.get_value("player")

	if player.is_moving:
		return SUCCESS
	else:
		return FAILURE
