extends Control

@export var visible_ui : Control
@onready var touch_to_jump: TouchScreenButton = $"../TouchToJump"
@onready var restart_button: Button = $RestartButton

signal restart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Make button work while paused
	restart_button.process_mode = Node.PROCESS_MODE_ALWAYS
	# Initially hide the game over screen
	visible_ui.hide()

func _on_killzone_game_over() -> void:
	visible_ui.show()
	# Hide and disable the jump button
	touch_to_jump.visible = false
	touch_to_jump.process_mode = Node.PROCESS_MODE_DISABLED

func _on_restart_button_pressed() -> void:
	restart.emit()
	# Re-enable jump button
	touch_to_jump.visible = true
	touch_to_jump.process_mode = Node.PROCESS_MODE_INHERIT
