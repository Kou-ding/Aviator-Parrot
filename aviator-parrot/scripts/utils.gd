extends Node

class_name Utils

const LEADERBOARD_SAVE_PATH := "user://leaderboard.save"
const CURRENCY_SAVE_PATH := "user://currency.save"
const SETTINGS_SAVE_PATH := "user://settings.save"
const PLAYER_SAVE_PATH := "user://player.save"
const BG_SAVE_PATH : = "user://bg.save"
const MAX_SCORES := 8

static func load_leaderboard() -> Array:
	var scores: Array = []
	
	if FileAccess.file_exists(LEADERBOARD_SAVE_PATH):
		var file = FileAccess.open(LEADERBOARD_SAVE_PATH, FileAccess.READ)
		scores = file.get_var()
		file.close()
	return scores

static func save_leaderboard(scores: Array) -> void:
	var file = FileAccess.open(LEADERBOARD_SAVE_PATH, FileAccess.WRITE)
	file.store_var(scores)
	file.close()

static func update_leaderboard(score) -> void:
	var scores = load_leaderboard()
	
	scores.append(score)
	scores.sort()
	scores.reverse() # highest first
	
	if scores.size() > MAX_SCORES:
		scores = scores.slice(0, MAX_SCORES)
	
	save_leaderboard(scores)
static func save_currency(score) -> void:
	var file = FileAccess.open(CURRENCY_SAVE_PATH,FileAccess.WRITE)
	file.store_var(score)
	file.close()
	
static func load_currency() -> int:
	var total_coins:int
	if FileAccess.file_exists(CURRENCY_SAVE_PATH):
		var file = FileAccess.open(CURRENCY_SAVE_PATH,FileAccess.READ)
		total_coins = file.get_var()
		file.close()
	return total_coins

static func update_currency(score) -> void:
	var total_coins = load_currency()
	total_coins += score
	save_currency(total_coins)

static func format_numbered_list(array: Array) -> String:
	var result: String = ""

	for i in range(array.size()):
		var number = i + 1  # Start counting from 1
		var item = str(array[i])  # Convert to string in case items aren't strings
		result += str(number) + ". " + item + " points"

		# Add newline except for last item
		if i < array.size() - 1:
			result += "\n"
	return result
	
static func format_numbered_list_shortVer(array: Array) -> String:
	var result: String = ""

	for i in range(3):
		var number = i + 1  # Start counting from 1
		var item = str(array[i])  # Convert to string in case items aren't strings
		result += str(number) + ". " + item + " points"

		# Add newline except for last item
		if i < array.size() - 1:
			result += "\n"
	
	return result
	
static func save_settings_before_quitting():
	var current_music_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	var current_sfx_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	save_settings(current_music_volume, current_sfx_volume)

static func load_settings_after_startup():
	var previous_volume = load_settings()
	var previous_music_volume = previous_volume[0]
	var previous_sfx_volume = previous_volume[1]
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),previous_music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),previous_sfx_volume)
	
static func save_settings(music_volume,sfx_volume) -> void:
	var file = FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.WRITE)
	if file:
		var data = [music_volume, sfx_volume]
		file.store_var(data)

static func load_settings() -> Array:
	if not FileAccess.file_exists(SETTINGS_SAVE_PATH):
		return [0,0]
	var file = FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.READ)
	if file:
		var data = file.get_var()
		return data
	return [0,0]

static func set_Player(player_tag):
	var file = FileAccess.open(PLAYER_SAVE_PATH, FileAccess.WRITE)
	if file:
		var data = player_tag
		file.store_var(data)

static func load_Player():
	if not FileAccess.file_exists(PLAYER_SAVE_PATH):
		return "parrot"
	var file = FileAccess.open(PLAYER_SAVE_PATH, FileAccess.READ)
	var data = file.get_var()
	return data
	
static func set_Bg(bg_tag):
	var file = FileAccess.open(BG_SAVE_PATH, FileAccess.WRITE)
	if file:
		var data = bg_tag
		file.store_var(data)

static func load_Bg():
	if not FileAccess.file_exists(BG_SAVE_PATH):
		return "stary night"
	var file = FileAccess.open(BG_SAVE_PATH, FileAccess.READ)
	var data = file.get_var()
	return data
