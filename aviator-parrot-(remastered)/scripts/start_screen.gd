extends Control

func _ready():
	MusicManager.play_start_music()

func _on_play_button_pressed() -> void:
	MusicManager.stop_music()
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_button_pressed() -> void:
	$Button_Sound.play()
	get_tree().quit()


func _on_leaderboard_button_pressed() -> void:
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")
