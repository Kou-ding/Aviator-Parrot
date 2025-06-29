extends Node2D

var pipe_speed = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	position.x -= pipe_speed*delta
