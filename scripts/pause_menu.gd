extends Control

# Pause Menu Controller
# Handles pause menu functionality and game state management

@onready var resume_button = $MainContainer/ResumeButton
@onready var settings_button = $MainContainer/SettingsButton
@onready var main_menu_button = $MainContainer/MainMenuButton
@onready var quit_button = $MainContainer/QuitButton

func _ready():
	# Connect button signals
	resume_button.pressed.connect(_on_resume_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Hide the pause menu initially
	visible = false
	
	# Set process mode to handle input even when paused
	process_mode = Node.PROCESS_MODE_ALWAYS

func _play_button_sound():
	# Try to play button click sound if it exists
	var sfx_path = "res://audio/sfx/button_click.ogg"
	if ResourceLoader.exists(sfx_path):
		var sfx = load(sfx_path)
		AudioManager.play_sfx(sfx)

func show_pause_menu():
	# Show the pause menu
	visible = true
	
	# Ensure proper positioning
	_ensure_proper_positioning()
	
	# Pause the game
	get_tree().paused = true
	
	# Pause audio
	if AudioManager:
		AudioManager.pause_audio()

func _ensure_proper_positioning():
	# Force the control to update its layout
	force_update_transform()
	
	# Ensure the menu covers the full viewport
	var viewport_size = get_viewport().get_visible_rect().size
	size = viewport_size
	position = Vector2.ZERO

func hide_pause_menu():
	# Hide the pause menu
	visible = false
	
	# Resume the game
	get_tree().paused = false
	
	# Resume audio
	if AudioManager:
		AudioManager.resume_audio()

func _on_resume_pressed():
	_play_button_sound()
	hide_pause_menu()

func _on_settings_pressed():
	_play_button_sound()
	# Navigate to settings menu
	SceneManager.change_scene("res://scenes/settings_menu.tscn")

func _on_main_menu_pressed():
	_play_button_sound()
	# Resume the game first to avoid issues
	get_tree().paused = false
	# Navigate to main menu
	SceneManager.change_scene("res://scenes/main_menu.tscn")

func _on_quit_pressed():
	_play_button_sound()
	# Resume the game first to avoid issues
	get_tree().paused = false
	# Quit the game
	get_tree().quit()

func _input(event):
	# Handle Escape key to toggle pause
	if event.is_action_pressed("ui_cancel"):
		if visible:
			_on_resume_pressed()
		else:
			show_pause_menu() 