extends Node2D

var crystals_scene = preload("res://scenes/crystals.tscn")
var parrot_scene = preload("res://scenes/parrot.tscn")
var slime_scene = preload("res://scenes/slime.tscn")

var score
var num_crystals
var Player
var Background

func new_game():
	# Player starting position
	var Player_tag = Utils.load_Player()
	match Player_tag:
		"parrot":
			Player = parrot_scene.instantiate()
			add_child(Player)
		"slime":
			Player = slime_scene.instantiate()
			add_child(Player)

	var Background_tag = Utils.load_Bg()
	match Background_tag:
		"stary night":
			$Background.texture = load("res://assets/bg.png")
		"start screen":
			$Background.texture = load("res://assets/back.png")
	
	Player.start($StartPosition.position)
	# Game music
	MusicManager.play_game_music()
	# Hide menus
	$GameOver.hide()
	$PauseMenu.hide()
	# Connect signals 
	$Killzone.game_over.connect(_on_game_over)
	$PauseMenu.undarken.connect(_on_unpause)
	# Show Instructions Timer
	await get_tree().create_timer(2.0).timeout
	var instructions = get_node_or_null("TapToJump/Instructions")
	var tap_area = get_node_or_null("TapToJump/TapArea")
	if instructions:
		instructions.queue_free()
	if tap_area:
		tap_area.queue_free()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	num_crystals = 0
	new_game()

func _on_crystal_spawner_timeout() -> void:
	var crystals = crystals_scene.instantiate()
	num_crystals = num_crystals+1
	print("crystals:",num_crystals)
	crystals.position.x = 1600
	crystals.position.y = randi()%500
	add_child(crystals)
	crystals.add_to_group("crystals")
	
	# Check if the player passed a crystal structure
	crystals.passed.connect(_on_passed)
	
	# Connect the crystals' killzone signal and process it on the _on_game_over function 
	var killzone = crystals.get_node("Killzone")
	killzone.game_over.connect(_on_game_over)

func _on_passed() -> void:
	score = score + 1
	
func _on_game_over() -> void:
	# Remove instructions if player lost too early
	var instructions = get_node_or_null("TapToJump/Instructions")
	var tap_area = get_node_or_null("TapToJump/TapArea")
	if instructions:
		instructions.queue_free()
	if tap_area:
		tap_area.queue_free()
		
	# Play lose sound and stop music
	$LoseSFX.play()
	MusicManager.stop()
	
	# Display Leaderboard
	Utils.update_leaderboard(score)
	var best_scores = Utils.load_leaderboard()
	$GameOver/Highscores.text = str(Utils.format_numbered_list_shortVer(best_scores))
	
	# Update Currency
	Utils.update_currency(score)
	
	# Darken bg and hide ui elements
	darken_scene()
	$PauseButton.hide()
	$GameOver.show()
	$JumpButton.hide()
	get_tree().paused = true

func _on_pause_button_pressed() -> void:
	darken_scene()
	$PauseMenu.show()
	$PauseButton.hide()
	$JumpButton.hide()
	$JumpButton.disabled = true
	get_tree().paused = true
	$ButtonSFX.play()
	
func darken_scene() -> void:
	$Background.modulate = Color(0.5, 0.5, 0.5)
	Player.modulate = Color(0.5, 0.5, 0.5)
	for crystal in get_tree().get_nodes_in_group("crystals"):
		crystal.modulate = Color(0.5, 0.5, 0.5)
		
func undarken_scene() -> void:
	$Background.modulate = Color(1, 1, 1)
	Player.modulate = Color(1, 1, 1)
	for crystal in get_tree().get_nodes_in_group("crystals"):
		crystal.modulate = Color(1, 1, 1)

func _on_unpause() -> void:
	undarken_scene()
	$PauseButton.show()
	$JumpButton.show()
	$JumpButton.disabled = false
	

func _on_jump_button_pressed() -> void:
	Player.game_jump_button_pressed()
