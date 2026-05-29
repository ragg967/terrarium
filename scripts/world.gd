extends Node2D
class_name World

@onready var label: Label = $LockPuzzle/Label
@onready var invisableWall: StaticBody2D = $LockPuzzle/AnimatedSprite2D/InvisableWall
@onready var player: Player = $Entites/Player
var playerInInteractArea: bool = false

func _process(delta: float) -> void:
	if playerInInteractArea and player.interacting:
		invisableWall.queue_free()

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and invisableWall:
		label.visible = true
		playerInInteractArea = true


func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.visible = false
		playerInInteractArea = false
