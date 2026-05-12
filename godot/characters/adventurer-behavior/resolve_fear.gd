@tool
extends ActionLeaf

func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.resolveFear()
	return SUCCESS
