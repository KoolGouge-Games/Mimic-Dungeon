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
				var camera_node = Camera2D.new()
				var remote_node = RemoteTransform2D.new()
				player_scene.add_child(remote_node)

				player_scene.global_position = entity.position

				entity_layer.add_child(camera_node)
				entity_layer.add_child(player_scene)
			"NPC_Spawn":
				var marker := Marker2D.new()
				marker.global_position = entity.position 
				entity_layer.add_child(marker)
			"Item":
				var itemScene := process_item(entity)
				entity_layer.add_child(itemScene)

	return entity_layer

func process_item(entity) -> Interactable:
	var interactable_scene: Interactable = INTERACTABLE.instantiate()
	var texture_path := "res://assets/objects/%s.png"

	match entity.fields.Item:
		"Item_type.Cursed":
			interactable_scene.ObjectType = Global.ObjectTypes.CURSED
			texture_path = texture_path % "Cursed"
		"Item_type.Heavy":
			interactable_scene.ObjectType = Global.ObjectTypes.HEAVY
			texture_path = texture_path % "Heavy"
		"Item_type.Locked":
			interactable_scene.ObjectType = Global.ObjectTypes.LOCKED
			texture_path = texture_path % "Locked"
		"Item_type.Magic":
			interactable_scene.ObjectType = Global.ObjectTypes.MAGICAL
			texture_path = texture_path % "Magic"
		_:
			interactable_scene.ObjectType = Global.ObjectTypes.BASIC
			texture_path = texture_path % "Basic"

	interactable_scene.get_child(0).texture = load(texture_path)
	
	interactable_scene.global_position = entity.position
	return interactable_scene
	
