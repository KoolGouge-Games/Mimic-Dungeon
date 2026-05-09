@tool
extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	print("fear!")
	actor.resolveFear()
	return SUCCESS
