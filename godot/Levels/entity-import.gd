@tool

const PLAYER = preload("res://characters/player.tscn")
const INTERACTABLE = preload("res://globals/interactable.tscn")

func post_import(entity_layer: LDTKEntityLayer) -> LDTKEntityLayer:
	var entities: Array = entity_layer.entities

	#print("EntityLayer: ", entity_layer.name, " | Count: ", entities.size())

	for entity in entities:
		match entity.identifier:
			"Player_Spawn":
				var player_scene = PLAYER.instantiate()
				player_scene.global_position = entity.position
				entity_layer.add_child(player_scene)
			"NPC_Spawn":
				var marker := Marker2D.new()
				marker.global_position = entity.position 
				entity_layer.add_child(marker)
			"Item":
				var interactable_scene: Interactable = INTERACTABLE.instantiate()

				print(entity.fields.Item)

				match entity.fields.Item:
					"Item_Type.Cursed":
						interactable_scene.ObjectType = Global.ObjectTypes.CURSED
					"Item_Type.Heavy":
						interactable_scene.ObjectType = Global.ObjectTypes.HEAVY
					"Item_Type.Locked":
						interactable_scene.ObjectType = Global.ObjectTypes.LOCKED
					"Item_Type.Magic":
						interactable_scene.ObjectType = Global.ObjectTypes.MAGICAL
					"Item_Type.Basic_Crate":
						interactable_scene.ObjectType = Global.ObjectTypes.BASIC

				interactable_scene.global_position = entity.position
				entity_layer.add_child(interactable_scene)

	return entity_layer
	
