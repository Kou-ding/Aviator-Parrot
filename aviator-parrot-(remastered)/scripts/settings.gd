extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/HBoxContainer/MusicSlider.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Music"))
	$VBoxContainer/HBoxContainer2/SFXSlider.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("SFX"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	Utils.save_settings_before_quitting()
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))


func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
