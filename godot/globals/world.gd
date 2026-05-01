extends Node2D

@onready var NPCAlertUI: Control = $CanvasLayer/NPCAlert

func _on_npc_queue(npcType: Global.NPCTypes) -> void:
	print("queued NPC of type: ", npcType)

func _on_button_pressed() -> void:
	NPCAlertUI.startNPCTimer(10, Global.NPCTypes.KNIGHT)

func _on_button_2_pressed() -> void:
	NPCAlertUI.startNPCTimer(10, Global.NPCTypes.MAGE)

func _on_button_3_pressed() -> void:
	NPCAlertUI.startNPCTimer(10, Global.NPCTypes.CLERIC)

func _on_button_4_pressed() -> void:
	NPCAlertUI.startNPCTimer(10, Global.NPCTypes.ROGUE)

