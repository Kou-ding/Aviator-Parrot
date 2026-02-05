extends Node

class_name Utils

const LEADERBOARD_SAVE_PATH := "user://leaderboard.save"
const CURRENCY_SAVE_PATH := "user://currency.save"
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
