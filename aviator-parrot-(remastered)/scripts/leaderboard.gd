extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Highscores.text = Utils.format_numbered_list(Utils.load_leaderboard())


func _on_back_pressed() -> void:
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
