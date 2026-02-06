extends Control

func _ready():
	Utils.load_settings_after_startup()
	MusicManager.play_start_music()
	if Utils.load_currency() == null:
		$CurrencyMargin/CurrencyGridContainer/CurrencyAmount.text = 0
	else:
		$CurrencyMargin/CurrencyGridContainer/CurrencyAmount.text = str(Utils.load_currency())

func _on_play_button_pressed() -> void:
	MusicManager.stop_music()
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_button_pressed() -> void:
	Utils.save_settings_before_quitting()
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().quit()

func _on_leaderboard_button_pressed() -> void:
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().change_scene_to_file("res://scenes/leaderboard.tscn")

func _on_options_button_pressed() -> void:
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
