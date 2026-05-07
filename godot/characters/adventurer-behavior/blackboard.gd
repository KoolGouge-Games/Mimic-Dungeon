extends Blackboard

@onready var player: Player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	set_value("player", player)
	print(player)

func _process(_delta: float) -> void:
	pass
