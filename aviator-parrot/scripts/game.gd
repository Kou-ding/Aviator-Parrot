extends Node2D

const pipe_scene = preload("res://scenes/pipe.tscn")
var pipes: Array = []  # Track spawned pipes

var spawn_timer: float = 0.0
const SPAWN_INTERVAL: float = 2.0  # Seconds between spawns

func _physics_process(delta: float) -> void:
	spawn_timer += delta
	if spawn_timer >= SPAWN_INTERVAL:
		spawn_timer = 0.0  # Reset timer
		spawn_pipe()
	# Cleanup offscreen pipes
	for pipe in pipes:
		if pipe.position.x < -100:  # 100 pixels past left edge
			pipe.queue_free()
			pipes.erase(pipe)
			
func spawn_pipe():
	if pipe_scene == null:
		printerr("Pipe scene not assigned!")
		return

	var new_pipe = pipe_scene.instantiate()
	add_child(new_pipe)
	# Set initial position (adjust as needed)
	new_pipe.position = Vector2(
		get_viewport_rect().size.x,  # Start offscreen right
		randf_range(get_viewport_rect().size.y - 1600, get_viewport_rect().size.y - 2300)  # Random vertical position
	)

func _on_game_over_restart() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
