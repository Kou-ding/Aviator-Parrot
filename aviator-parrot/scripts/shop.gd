extends Control

var active_player
var active_bg

var shop_type
enum ShopType {player,bg}
var shop_mode
enum ShopMode {buying,selecting,viewing}

var item_price

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DetailsPanel.hide()
	render_locks()
	render_selections()
	# Remove all owned items for functionality testing
	#DirAccess.remove_absolute("user://owned_players.save")
	#DirAccess.remove_absolute("user://owned_bgs.save")
	# Add money to be able to buy items
	#Utils.save_currency(1000)


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
	if Utils.bg_is_owned("moon"):
		$ScrollContainer2/GridContainer/moon/lock.hide()
		$ScrollContainer2/GridContainer/moon/TextureRect.hide()
	if Utils.bg_is_owned("space"):
		$ScrollContainer2/GridContainer/space/lock.hide()
		$ScrollContainer2/GridContainer/space/TextureRect.hide()

func render_selections():
	# Hide all selections
	if Utils.load_Player() == "parrot":
		$ScrollContainer/GridContainer/parrot/selected.show()
	else:
		$ScrollContainer/GridContainer/parrot/selected.hide()
	if Utils.load_Player() == "slime":	
		$ScrollContainer/GridContainer/slime/selected.show()
	else:
		$ScrollContainer/GridContainer/slime/selected.hide()
	if Utils.load_Bg() == "moon":
		$ScrollContainer2/GridContainer/moon/selected.show()
	else:
		$ScrollContainer2/GridContainer/moon/selected.hide()
	if Utils.load_Bg() == "space":
		$ScrollContainer2/GridContainer/space/selected.show()
	else:
		$ScrollContainer2/GridContainer/space/selected.hide()
	
func configure_details_player(player_tag,player_price):
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
		$DetailsPanel/BuySelect/CoinSymbol.show()
		item_price = player_price
		shop_mode = ShopMode.buying
	$DetailsPanel/Error.hide()

func configure_details_bg(bg_tag,bg_price):
	# Allow buying if not owned and selecting if not selected
	if Utils.bg_is_owned(bg_tag) and Utils.bg_is_selected(bg_tag):
		$DetailsPanel/BuySelect.text = "SELECTED"
		$DetailsPanel/BuySelect/CoinSymbol.hide()
		shop_mode = ShopMode.viewing
	elif Utils.bg_is_owned(bg_tag) and not Utils.bg_is_selected(bg_tag):
		$DetailsPanel/BuySelect.text = "SELECT"
		$DetailsPanel/BuySelect/CoinSymbol.hide()
		shop_mode = ShopMode.selecting
	else:
		$DetailsPanel/BuySelect.text = "BUY - " + str(bg_price)
		$DetailsPanel/BuySelect/CoinSymbol.show()
		item_price = bg_price
		shop_mode = ShopMode.buying
	$DetailsPanel/Error.hide()

func darken():
	$Background.modulate = Color(0.5, 0.5, 0.5)
	$Control.modulate = Color(0.5, 0.5, 0.5)
	$ScrollContainer.modulate = Color(0.5, 0.5, 0.5)
	$ScrollContainer2.modulate = Color(0.5, 0.5, 0.5)
	$PlayersLabel.modulate = Color(0.5, 0.5, 0.5)
	$BackgroundsLabel.modulate = Color(0.5, 0.5, 0.5)
	$Control/MarginContainer/HBoxContainer/Back.disabled = true
	$ScrollContainer/GridContainer/parrot.disabled = true
	$ScrollContainer/GridContainer/slime.disabled = true
	$ScrollContainer2/GridContainer/moon.disabled = true
	$ScrollContainer2/GridContainer/space.disabled = true
	

func undarken():
	$Background.modulate = Color(1, 1, 1)
	$Control.modulate = Color(1, 1, 1)
	$ScrollContainer.modulate = Color(1, 1, 1)
	$ScrollContainer2.modulate = Color(1, 1, 1)
	$PlayersLabel.modulate = Color(1, 1, 1)
	$BackgroundsLabel.modulate = Color(1, 1, 1)
	$Control/MarginContainer/HBoxContainer/Back.disabled = false
	$ScrollContainer/GridContainer/parrot.disabled = false
	$ScrollContainer/GridContainer/slime.disabled = false
	$ScrollContainer2/GridContainer/moon.disabled = false
	$ScrollContainer2/GridContainer/space.disabled = false
	
	
func _on_back_pressed() -> void:
	$Button_Sound.play()
	await $Button_Sound.finished
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")

# All Available upgrades 
func _on_parrot_pressed() -> void:
	var player_tag = "parrot"
	active_player=player_tag
	shop_type = ShopType.player
	# Name
	$DetailsPanel/NameMargin/ItemName.text = player_tag
	# Icon
	var player_icon = $DetailsPanel/MarginContainer/ItemIcon
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = load("res://assets/mc.png")
	atlas_texture.region = Rect2(0, 0, 456.0, 424.0)
	player_icon.texture = atlas_texture
	
	# Buy, select, selected bar
	configure_details_player(player_tag,1)
	$DetailsPanel.show()
	darken()


func _on_slime_pressed() -> void:
	var player_tag = "slime"
	active_player=player_tag
	shop_type = ShopType.player
	# Name
	$DetailsPanel/NameMargin/ItemName.text = player_tag
	# Icon
	var player_icon = $DetailsPanel/MarginContainer/ItemIcon
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = load("res://assets/slime.png")
	atlas_texture.region = Rect2(720,160, 464.0, 376.0)
	player_icon.texture = atlas_texture
	
	# Buy, select, selected bar
	configure_details_player(player_tag,200)
	$DetailsPanel.show()
	darken()

func _on_moon_pressed() -> void:
	var bg_tag = "moon"
	active_bg=bg_tag
	shop_type = ShopType.bg
	# Name
	$DetailsPanel/NameMargin/ItemName.text = bg_tag
	# Icon
	$DetailsPanel/MarginContainer/ItemIcon.texture = load("res://assets/bg.png")
	
	# Buy, select, selected bar
	configure_details_bg(bg_tag,1)
	$DetailsPanel.show()
	darken()

func _on_space_pressed() -> void:
	var bg_tag = "space"
	active_bg=bg_tag
	shop_type = ShopType.bg
	# Name
	$DetailsPanel/NameMargin/ItemName.text = bg_tag
	# Icon
	var icon = $DetailsPanel/MarginContainer/ItemIcon
	icon.texture = load("res://assets/back.png")
	
	# Buy, select, selected bar
	configure_details_bg(bg_tag,200)
	$DetailsPanel.show()
	darken()

# Details menu
func _on_buy_select_pressed() -> void:
	if shop_type == ShopType.player:
		if shop_mode == ShopMode.buying:
			var current_currency = Utils.load_currency()
			if current_currency < item_price:
				$DetailsPanel/Error.show()
				return
			else:
				Utils.save_currency(current_currency - item_price)
				Utils.buy_Player(active_player)
				render_locks()
				$DetailsPanel/BuySelect.text = "SELECT"
				$DetailsPanel/BuySelect/CoinSymbol.hide()
				shop_mode = ShopMode.selecting
				return
		if shop_mode == ShopMode.selecting:
			Utils.set_Player(active_player)
			$DetailsPanel/BuySelect.text = "SELECTED"
			$DetailsPanel/BuySelect/CoinSymbol.hide()
			render_selections()
			return
	if shop_type == ShopType.bg:
		if shop_mode == ShopMode.buying:
			var current_currency = Utils.load_currency()
			if current_currency < item_price:
				$DetailsPanel/Error.show()
				return
			else:
				Utils.save_currency(current_currency - item_price)
				Utils.buy_Bg(active_bg)
				render_locks()
				$DetailsPanel/BuySelect.text = "SELECT"
				$DetailsPanel/BuySelect/CoinSymbol.hide()
				shop_mode = ShopMode.selecting
				return
		if shop_mode == ShopMode.selecting:
			Utils.set_Bg(active_bg)
			$DetailsPanel/BuySelect.text = "SELECTED"
			render_selections()
			$DetailsPanel/BuySelect/CoinSymbol.hide()
			return

func _on_exit_details_pressed() -> void:
	$Button_Sound.play()
	await $Button_Sound.finished
	$DetailsPanel.hide()
	render_locks()
	undarken()
