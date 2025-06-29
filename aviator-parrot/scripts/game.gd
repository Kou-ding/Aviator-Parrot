extends Node2D

@onready var touch_screen_start_button: TouchScreenButton = $MainMenu/StartButton/TouchScreenStartButton
@onready var start_button: Button   = $MainMenu/StartButton
@onready var main_menu:  Control    = $MainMenu
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var pipes: Array = []      # Track spawned pipes

func _ready() -> void:
	# Were we already past the menu once?
	if GameState.show_menu:
		_show_main_menu()
	else:
		_start_game()      # jump straight into gameplay

func _show_main_menu() -> void:
	get_tree().paused = true
	start_button.process_mode = Node.PROCESS_MODE_ALWAYS
	touch_screen_start_button.process_mode = Node.PROCESS_MODE_ALWAYS
	main_menu.show()
	canvas_layer.hide()

func _start_game() -> void:
	get_tree().paused = false
	main_menu.hide()
	canvas_layer.show()

	# Ensure pipes exist & are in starting positions
	if has_node("Pipe") and has_node("Pipe2"):
		$Pipe.position.x  = 600
		$Pipe2.position.x = 1200
		pipes = [$Pipe, $Pipe2]
	else:
		printerr("Pipe nodes not found in scene!")

func _on_start_button_pressed() -> void:
	GameState.show_menu = false     # Don’t show it again this run
	_start_game()

func _on_touch_screen_start_button_pressed() -> void:
	GameState.show_menu = false     # Don’t show it again this run
	_start_game()
	
func _physics_process(_delta: float) -> void:
	for pipe in pipes:
		if pipe.position.x < -600:
			pipe.position.x = 600

func _on_game_over_restart() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()   # _ready() will be called again
