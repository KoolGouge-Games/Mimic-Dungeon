extends Node2D

@onready var NPCAlertUI: Control = %NPCAlert

@onready var current_level := $Debug_Level

func _on_queue_adventurer(type: Global.NPCTypes) -> void:
	NPCAlertUI.startNPCTimer(3.0, type)

func _on_npc_alert_spawn_npc(type: Global.NPCTypes) -> void:
	current_level.spawn_npc(type)
