extends Control

@onready var pause_button: Button = $PauseButton
@onready var touch_screen_pause_button: TouchScreenButton = $PauseButton/TouchScreenPauseButton

const BUTTON_PAUSE = preload("res://assets/flappybird/button_pause.png")
const BUTTON_RESUME = preload("res://assets/flappybird/button_resume.png")

func _ready():
	# Make button work while paused
	pause_button.process_mode = Node.PROCESS_MODE_ALWAYS
	touch_screen_pause_button.process_mode = Node.PROCESS_MODE_ALWAYS
	# Set initial icon
	pause_button.icon = BUTTON_PAUSE

func _on_pause_button_pressed() -> void:
	if get_tree().paused==false:
		get_tree().paused = true
		pause_button.icon=BUTTON_RESUME
	elif get_tree().paused==true:
		get_tree().paused = false
		pause_button.icon=BUTTON_PAUSE

func _on_touch_screen_pause_button_pressed() -> void:
	if get_tree().paused==false:
		get_tree().paused = true
		pause_button.icon=BUTTON_RESUME
	elif get_tree().paused==true:
		get_tree().paused = false
		pause_button.icon=BUTTON_PAUSE
