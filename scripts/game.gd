extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D
@onready var score_label = $UI/ScoreLabel

var pause_menu: Control
var coin_count = 0

func _ready():
	# Initialize the game scene
	print("Mario-style platformer loaded!")
	print("Player position: ", player.position if player else "Player not found!")
	print("Camera position: ", camera.position if camera else "Camera not found!")
	
	# Create pause menu dynamically
	_create_pause_menu()
	
	# Try to play game music if it exists
	_play_game_music()
	
	# Connect coin collection signals with a small delay to ensure coins are ready
	await get_tree().process_frame
	_connect_coin_signals()
	
	# Update score display
	_update_score_display()

func _create_pause_menu():
	# Load and create the pause menu
	var pause_scene = preload("res://scenes/pause_menu.tscn")
	pause_menu = pause_scene.instantiate()
	
	# Add it to the scene tree root to ensure proper positioning
	get_tree().root.add_child(pause_menu)
	
	# Initially hide it
	pause_menu.visible = false

func _play_game_music():
	# Try to load and play game music if it exists
	var music_path = "res://audio/music/game_music.ogg"
	if ResourceLoader.exists(music_path):
		var music = load(music_path)
		AudioManager.play_music(music, true)

func _connect_coin_signals():
	# Connect all coin collection signals
	var coins = get_node("Coins")
	print("Found ", coins.get_child_count(), " coins")
	for coin in coins.get_children():
		print("Connecting signal for coin: ", coin.name)
		if coin.has_signal("coin_collected"):
			coin.coin_collected.connect(_on_coin_collected)
			print("Signal connected for ", coin.name)
		else:
			print("No coin_collected signal found for ", coin.name)

func _on_coin_collected():
	coin_count += 1
	_update_score_display()
	print("Coin collected! Total: ", coin_count)

func _update_score_display():
	if score_label:
		score_label.text = "Coins: " + str(coin_count)

func _input(event):
	# Handle input for the game scene
	if event.is_action_pressed("ui_cancel"):
		# Show pause menu when Escape is pressed
		if pause_menu:
			pause_menu.show_pause_menu()

func _exit_tree():
	# Clean up pause menu when scene is exited
	if pause_menu and is_instance_valid(pause_menu):
		pause_menu.queue_free() 
