extends Control

# Settings Menu Controller
# Provides UI for accessing and modifying game settings

# Audio controls
@onready var master_volume_slider = $MainContainer/TabContainer/Audio/MasterVolumeContainer/MasterVolumeSlider
@onready var master_volume_value = $MainContainer/TabContainer/Audio/MasterVolumeContainer/MasterVolumeValue
@onready var music_volume_slider = $MainContainer/TabContainer/Audio/MusicVolumeContainer/MusicVolumeSlider
@onready var music_volume_value = $MainContainer/TabContainer/Audio/MusicVolumeContainer/MusicVolumeValue
@onready var sfx_volume_slider = $MainContainer/TabContainer/Audio/SFXVolumeContainer/SFXVolumeSlider
@onready var sfx_volume_value = $MainContainer/TabContainer/Audio/SFXVolumeContainer/SFXVolumeValue

# Display controls
@onready var fullscreen_checkbox = $MainContainer/TabContainer/Display/FullscreenContainer/FullscreenCheckBox
@onready var vsync_checkbox = $MainContainer/TabContainer/Display/VSyncContainer/VSyncCheckBox
@onready var loading_time_slider = $MainContainer/TabContainer/Display/LoadingTimeContainer/LoadingTimeSlider
@onready var loading_time_value = $MainContainer/TabContainer/Display/LoadingTimeContainer/LoadingTimeValue

# UI controls
@onready var show_tips_checkbox = $MainContainer/TabContainer/UI/ShowTipsContainer/ShowTipsCheckBox
@onready var show_version_checkbox = $MainContainer/TabContainer/UI/ShowVersionContainer/ShowVersionCheckBox

# Buttons
@onready var reset_button = $MainContainer/ButtonContainer/ResetButton
@onready var back_button = $MainContainer/ButtonContainer/BackButton

# Audio preview timer
var audio_preview_timer: Timer

func _ready():
	# Create audio preview timer
	audio_preview_timer = Timer.new()
	audio_preview_timer.wait_time = 0.1
	audio_preview_timer.one_shot = true
	add_child(audio_preview_timer)
	
	# Connect signals
	_connect_signals()
	
	# Load current settings into UI
	_load_current_settings()
	
	# Try to play menu music
	_play_menu_music()

func _connect_signals():
	# Audio sliders
	master_volume_slider.value_changed.connect(_on_master_volume_changed)
	music_volume_slider.value_changed.connect(_on_music_volume_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_volume_changed)
	
	# Display controls
	fullscreen_checkbox.toggled.connect(_on_fullscreen_toggled)
	vsync_checkbox.toggled.connect(_on_vsync_toggled)
	loading_time_slider.value_changed.connect(_on_loading_time_changed)
	
	# UI controls
	show_tips_checkbox.toggled.connect(_on_show_tips_toggled)
	show_version_checkbox.toggled.connect(_on_show_version_toggled)
	
	# Buttons
	reset_button.pressed.connect(_on_reset_pressed)
	back_button.pressed.connect(_on_back_pressed)

func _load_current_settings():
	# Load audio settings
	master_volume_slider.value = SettingsManager.get_setting("audio", "master_volume", 1.0)
	music_volume_slider.value = SettingsManager.get_music_volume()
	sfx_volume_slider.value = SettingsManager.get_sfx_volume()
	_update_volume_labels()
	
	# Load display settings
	fullscreen_checkbox.button_pressed = SettingsManager.is_fullscreen()
	vsync_checkbox.button_pressed = SettingsManager.get_setting("game", "vsync", true)
	loading_time_slider.value = SettingsManager.get_loading_time()
	loading_time_value.text = str(loading_time_slider.value) + "s"
	
	# Load UI settings
	show_tips_checkbox.button_pressed = SettingsManager.get_setting("ui", "show_tips", true)
	show_version_checkbox.button_pressed = SettingsManager.get_setting("ui", "show_version", true)

func _update_volume_labels():
	master_volume_value.text = str(int(master_volume_slider.value * 100)) + "%"
	music_volume_value.text = str(int(music_volume_slider.value * 100)) + "%"
	sfx_volume_value.text = str(int(sfx_volume_slider.value * 100)) + "%"

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

func _play_volume_preview():
	# Play a preview sound when volume changes
	var sfx_path = "res://audio/sfx/volume_preview.ogg"
	if ResourceLoader.exists(sfx_path):
		var sfx = load(sfx_path)
		AudioManager.play_sfx(sfx)

# Audio control handlers
func _on_master_volume_changed(value: float):
	SettingsManager.set_setting("audio", "master_volume", value)
	_update_volume_labels()
	_play_volume_preview()

func _on_music_volume_changed(value: float):
	SettingsManager.set_music_volume(value)
	_update_volume_labels()

func _on_sfx_volume_changed(value: float):
	SettingsManager.set_sfx_volume(value)
	_update_volume_labels()
	_play_volume_preview()

# Display control handlers
func _on_fullscreen_toggled(button_pressed: bool):
	SettingsManager.set_fullscreen(button_pressed)

func _on_vsync_toggled(button_pressed: bool):
	SettingsManager.set_setting("game", "vsync", button_pressed)

func _on_loading_time_changed(value: float):
	SettingsManager.set_loading_time(value)
	loading_time_value.text = str(value) + "s"

# UI control handlers
func _on_show_tips_toggled(button_pressed: bool):
	SettingsManager.set_setting("ui", "show_tips", button_pressed)

func _on_show_version_toggled(button_pressed: bool):
	SettingsManager.set_setting("ui", "show_version", button_pressed)

# Button handlers
func _on_reset_pressed():
	_play_button_sound()
	SettingsManager.reset_to_defaults()
	_load_current_settings()

func _on_back_pressed():
	_play_button_sound()
	# Check if we should return to game or main menu
	if get_tree().paused:
		# We came from pause menu, return to game
		SceneManager.change_scene("res://scenes/game.tscn")
	else:
		# We came from main menu, return to main menu
		SceneManager.change_scene("res://scenes/main_menu.tscn")

func _input(event):
	# Handle Escape key to go back
	if event.is_action_pressed("ui_cancel"):
		_on_back_pressed() 