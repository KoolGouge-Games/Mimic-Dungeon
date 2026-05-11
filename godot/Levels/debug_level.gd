extends Level_Script

func _on_button_pressed() -> void:
	var npcTypes = [Global.NPCTypes.KNIGHT, Global.NPCTypes.ROGUE, Global.NPCTypes.CLERIC, Global.NPCTypes.MAGE]
	queue_npc(npcTypes.pick_random())
