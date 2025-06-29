extends Node2D

var pipes: Array = []  # Track spawned pipes

func _ready():
	# Explicitly get the nodes and check they exist
	if has_node("Pipe") and has_node("Pipe2"):
		$Pipe.position.x = 600
		$Pipe2.position.x = 1200
		pipes = [$Pipe, $Pipe2]
		print("All pipes present!")
	else:
		printerr("Pipe nodes not found in scene!")

func _physics_process(_delta: float) -> void:
	# Move all active pipes
	for pipe in pipes:
		if pipe.position.x < -600:  # If pipe is out of the screen (left)
			pipe.position.x = 600  # Move it out of the screen (right)

func _on_game_over_restart() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
