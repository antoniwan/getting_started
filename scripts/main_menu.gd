extends Control

@onready var new_game_button = $VBoxContainer/NewGameButton
@onready var settings_button = $VBoxContainer/SettingsButton
@onready var quit_button = $VBoxContainer/QuitButton

func _ready():
	# Connect button signals
	new_game_button.pressed.connect(_on_new_game_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Try to play menu music
	_play_menu_music()

func _play_menu_music():
	# Try to load and play menu music if it exists
	var music_path = "res://audio/music/menu_music.ogg"
	if ResourceLoader.exists(music_path):
		var music = load(music_path)
		AudioManager.play_music(music, true)

func _play_button_sound():
	# Try to play button click sound if it exists
	var sfx_path = "res://audio/sfx/button_click.ogg"
	if ResourceLoader.exists(sfx_path):
		var sfx = load(sfx_path)
		AudioManager.play_sfx(sfx)

func _on_new_game_pressed():
	# Play button sound
	_play_button_sound()
	
	# Transition to the game scene
	SceneManager.change_scene("res://scenes/game.tscn")

func _on_settings_pressed():
	# Play button sound
	_play_button_sound()
	
	# Transition to the settings menu
	SceneManager.change_scene("res://scenes/settings_menu.tscn")

func _on_quit_pressed():
	# Play button sound
	_play_button_sound()
	
	# Quit the game
	get_tree().quit() 
