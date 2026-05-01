extends Control

@onready var NPCTimer: Timer = %NPCTimer
@onready var TimerBar: ProgressBar = %TimerBar
@onready var portriatElement: TextureRect = %NPCProfile

signal queueNPC

func _process(_delta: float) -> void:
	TimerBar.value = NPCTimer.time_left

func startNPCTimer(duration: float, NPCType: Global.NPCTypes):
	var npcString: String
	var pathString := "res://assets/UI Elements/%s-Portrait.png"

	match NPCType:
		Global.NPCTypes.KNIGHT:
			npcString = "Knight"
		Global.NPCTypes.ROGUE:
			npcString = "Rogue"
		Global.NPCTypes.CLERIC:
			npcString = "Cleric"
		Global.NPCTypes.MAGE:
			npcString = "Mage"

	portriatElement.texture = load(pathString % npcString)
	NPCTimer.wait_time = duration
	TimerBar.max_value = duration
	self.visible = true
	NPCTimer.start()

func _on_npc_timer_timeout() -> void:
	self.visible = false
	queueNPC.emit(Global.NPCTypes.ROGUE)
