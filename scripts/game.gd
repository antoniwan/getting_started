extends Node2D

@onready var moving_object = $MovingObject

var pause_menu: Control
var move_speed = 100.0
var direction = Vector2(1, 1)

func _ready():
	# Initialize the game scene
	print("Game scene loaded - ready for your game content!")
	
	# Create pause menu dynamically
	_create_pause_menu()
	
	# Try to play game music if it exists
	_play_game_music()

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

func _process(delta):
	# Move the object to demonstrate pause functionality
	if moving_object:
		var new_position = moving_object.position + direction * move_speed * delta
		
		# Bounce off screen edges
		if new_position.x <= 0 or new_position.x >= 1000:
			direction.x *= -1
		if new_position.y <= 0 or new_position.y >= 500:
			direction.y *= -1
		
		moving_object.position = new_position

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
