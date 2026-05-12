@tool

func post_import(level: LDTKLevel) -> LDTKLevel:
	var level_children = level.get_children()
	level_children[0].texture_filter = 1
	level_children[1].texture_filter = 1

	var camera_node = Camera2D.new()
	level.add_child(camera_node)

	var music_node = FmodEventEmitter2D.new()
	level.add_child(music_node)

	return level
