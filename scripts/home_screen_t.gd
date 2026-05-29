extends Button

const TUTORIAL_WORLD = preload("uid://dk7j1qcwp2226")

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	get_tree().call_deferred("change_scene_to_packed", TUTORIAL_WORLD)
