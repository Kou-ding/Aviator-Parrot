extends Control

signal undarken

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")

func _on_resume_pressed() -> void:
	get_tree().paused = false
	hide()
	emit_signal("undarken")
