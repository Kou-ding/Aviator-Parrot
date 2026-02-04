extends AudioStreamPlayer

const start_music = preload("uid://d18k42a01kbqf")
const game_music = preload("uid://bwp24ix5ww824")

var current_music_name: String = ""

# Called when the node enters the scene tree for the first time.
func _play_music(music: AudioStream, music_name: String, volume = 0.0):
	if current_music_name == music_name and playing:
		return  # Already playing this music

	stream = music
	volume_db = volume
	current_music_name = music_name
	play()

func stop_music():
	stop()
	current_music_name = ""

func get_current_music() -> String:
	return current_music_name

func play_start_music():
	_play_music(start_music, "start")
	
func play_game_music():
	_play_music(game_music, "game")
