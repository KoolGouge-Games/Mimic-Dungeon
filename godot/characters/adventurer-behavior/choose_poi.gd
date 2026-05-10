@tool
extends ConditionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	var choice :Node = actor.choosePOI()
	if choice:
		blackboard.set_value("POIChoice", choice)
		return SUCCESS
	else:
		return FAILURE

