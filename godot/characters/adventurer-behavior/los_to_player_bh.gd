@tool
extends ConditionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.LOS_to_player:
		return SUCCESS
	else:
		return FAILURE

