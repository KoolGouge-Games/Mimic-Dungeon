extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func load_scene(scene_path: String) -> void:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene_path)
	animation_player.play_backwards("fade_to_black")

func reload_scene() -> void:
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play_backwards("fade_to_black")

