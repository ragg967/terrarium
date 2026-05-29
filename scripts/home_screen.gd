extends Control

const WORLD_SELECTOR = preload("uid://bwdsaa2s1muwg")

func _on_play_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", WORLD_SELECTOR)

func _on_options_pressed() -> void:
	print("Opened options")

func _on_exit_pressed() -> void:
	get_tree().quit()
