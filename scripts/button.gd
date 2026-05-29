extends Button

var filePath: String
var levelFolder: String = "res://levels/"
var levelSufix: String = ".tscn"

func  _ready() -> void:
	filePath = levelFolder + name + levelSufix

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if button_pressed:
		get_tree().call_deferred("change_scene_to_file", filePath)
