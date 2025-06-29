extends Area2D

@export var game_over_screen: PackedScene

signal game_over

func _on_body_entered(body: Node2D) -> void:
	# If the parrot falls on the floor go to the game over screen
	if body.name == "Parrot":
		print("Game Over!")
		game_over.emit()
		get_tree().paused = true
