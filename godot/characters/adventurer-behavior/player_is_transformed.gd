@tool
extends ConditionLeaf


func tick(_actor: Node, blackboard: Blackboard) -> int:
	var player: Player = blackboard.get_value("player")
	
	if player.is_transformed:
		return SUCCESS
	else:
		return FAILURE
