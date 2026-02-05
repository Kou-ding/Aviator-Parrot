extends AudioStreamPlayer

var start_music = preload("uid://d18k42a01kbqf")
var game_music = preload("uid://bwp24ix5ww824")

# Called when the node enters the scene tree for the first time.
func _ready():
	start_music.loop = true
	game_music.loop = true

func _play_music(music: AudioStream, volume = 0.0):
	# Do nothing if the same song is selected and is currently playing
	if stream == music and playing:
		return
	stream = music
	volume_db = volume
	play()

func play_FX(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	# Wait until fx finished to free object
	await fx_player.finished
	fx_player.queue_free()

func stop_music():
	stop()

func play_start_music():
	_play_music(start_music)
	
func play_game_music():
	_play_music(game_music)
