@tool
extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.resolveFear()
	return SUCCESS
