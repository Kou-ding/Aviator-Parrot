extends Control

var active_player
var shop_mode
var item_price
enum ShopMode {buying,selecting,viewing}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DetailsPanel.hide()
	render_locks()
	#DirAccess.remove_absolute("user://owned_players.save")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func render_locks():
	if Utils.player_is_owned("parrot"):
		$ScrollContainer/GridContainer/parrot/lock.hide()
		$ScrollContainer/GridContainer/parrot/TextureRect.hide()
	if Utils.player_is_owned("slime"):
		$ScrollContainer/GridContainer/slime/lock.hide()
		$ScrollContainer/GridContainer/slime/TextureRect.hide()

func configure_details(player_tag,player_price):
	# Allow buying if not owned and selecting if not selected
	if Utils.player_is_owned(player_tag) and Utils.player_is_selected(player_tag):
		$DetailsPanel/BuySelect.text = "SELECTED"
		$DetailsPanel/BuySelect/CoinSymbol.hide()
		shop_mode = ShopMode.viewing
	elif Utils.player_is_owned(player_tag) and not Utils.player_is_selected(player_tag):
		$DetailsPanel/BuySelect.text = "SELECT"
		$DetailsPanel/BuySelect/CoinSymbol.hide()
		shop_mode = ShopMode.selecting
	else:
		$DetailsPanel/BuySelect.text = "BUY - " + str(player_price)
		item_price = player_price
		shop_mode = ShopMode.buying

func darken():
	$Background.modulate = Color(0.5, 0.5, 0.5)
	$Control.modulate = Color(0.5, 0.5, 0.5)
	$ScrollContainer.modulate = Color(0.5, 0.5, 0.5)
	$ScrollContainer2.modulate = Color(0.5, 0.5, 0.5)
	$PlayersLabel.modulate = Color(0.5, 0.5, 0.5)
	$BackgroundsLabel.modulate = Color(0.5, 0.5, 0.5)
	$Control/MarginContainer/HBoxContainer/Back.disabled = true

func undarken():
	$Background.modulate = Color(1, 1, 1)
	$Control.modulate = Color(1, 1, 1)
	$ScrollContainer.modulate = Color(1, 1, 1)
	$ScrollContainer2.modulate = Color(1, 1, 1)
	$PlayersLabel.modulate = Color(1, 1, 1)
	$BackgroundsLabel.modulate = Color(1, 1, 1)
	$Control/MarginContainer/HBoxContainer/Back.disabled = false
	
func _on_back_pressed() -> void:
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")

# All Available upgrades 
func _on_parrot_pressed() -> void:
	var player_tag = "parrot"
	active_player=player_tag
	
	# Name
	$DetailsPanel/NameMargin/ItemName.text = player_tag
	# Icon
	var player_icon = $DetailsPanel/MarginContainer/ItemIcon
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = load("res://assets/mc.png")
	atlas_texture.region = Rect2(0, 0, 456.0, 424.0)
	player_icon.texture = atlas_texture
	
	# Buy, select, selected bar
	configure_details(player_tag,1)
	$DetailsPanel.show()
	darken()


func _on_slime_pressed() -> void:
	var player_tag = "slime"
	active_player=player_tag
	
	# Name
	$DetailsPanel/NameMargin/ItemName.text = player_tag
	# Icon
	var player_icon = $DetailsPanel/MarginContainer/ItemIcon
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = load("res://assets/slime.png")
	atlas_texture.region = Rect2(720,160, 464.0, 376.0)
	player_icon.texture = atlas_texture
	
	# Buy, select, selected bar
	configure_details(player_tag,1)
	$DetailsPanel.show()
	darken()



func _on_moon_pressed() -> void:
	pass # Replace with function body.


func _on_space_pressed() -> void:
	pass # Replace with function body.


func _on_buy_select_pressed() -> void:
	if shop_mode == ShopMode.buying:
		var current_currency = Utils.load_currency()
		Utils.save_currency(current_currency - item_price)
		Utils.buy_Player(active_player)
		Utils.set_Player(active_player)
		$DetailsPanel/BuySelect.text = "SELECT"
		shop_mode = ShopMode.selecting
		return
	if shop_mode == ShopMode.selecting:
		Utils.set_Player(active_player)
		$DetailsPanel/BuySelect.text = "SELECTED"
		return

func _on_exit_details_pressed() -> void:
	$Button_Sound.play()
	await $Button_Sound.finished
	$DetailsPanel.hide()
	render_locks()
	undarken()
