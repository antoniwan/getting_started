extends Control

@onready var progress_bar = $VBoxContainer/ProgressBar
@onready var loading_label = $VBoxContainer/LoadingLabel
@onready var tip_label = $VBoxContainer/TipLabel
@onready var version_label = $VBoxContainer/VersionLabel
@onready var title_label = $VBoxContainer/Title
@onready var subtitle_label = $VBoxContainer/Subtitle
@onready var background = $Background
@onready var particles = $Particles2D

var loading_time = SettingsManager.get_loading_time()  # Time in seconds to show loading screen
var current_time = 0.0
var loading_stage = 0
var loading_stages = [
	"Initializing...",
	"Loading Assets...",
	"Preparing Game...",
	"Almost Ready..."
]

var loading_tips = [
	"Tip: Press ESC to return to the main menu during gameplay",
	"Tip: This template is perfect for starting new game projects",
	"Tip: Check the README.md for customization instructions",
	"Tip: Add your own game content to the game.tscn scene",
	"Tip: The SceneManager handles all scene transitions automatically",
	"Tip: Customize colors and styling in each scene file",
	"Tip: Add sound effects and music to enhance your game",
	"Tip: Use the audio folder for your game's sound assets"
]

var current_tip = 0
var tip_change_time = 0.0
var tip_duration = 1.5

func _ready():
	# Initialize the loading screen
	progress_bar.value = 0
	loading_label.text = loading_stages[0]
	tip_label.text = loading_tips[0]
	version_label.text = "v1.0.0"
	
	# Show/hide elements based on settings
	tip_label.visible = SettingsManager.get_setting("ui", "show_tips", true)
	version_label.visible = SettingsManager.get_setting("ui", "show_version", true)
	
	# Start the loading timer
	current_time = 0.0
	tip_change_time = 0.0
	
	# Start title animation
	_start_title_animation()
	
	# Start background animation
	_start_background_animation()
	
	# Try to play loading music if available
	_play_loading_music()

func _process(delta):
	current_time += delta
	tip_change_time += delta
	
	# Update progress bar with smooth animation
	var progress = (current_time / loading_time) * 100
	progress_bar.value = lerp(progress_bar.value, progress, delta * 3)
	
	# Update loading stage
	var stage_progress = (current_time / loading_time) * loading_stages.size()
	var current_stage = min(int(stage_progress), loading_stages.size() - 1)
	
	if current_stage != loading_stage:
		loading_stage = current_stage
		loading_label.text = loading_stages[loading_stage]
	
	# Update loading text with dots animation
	var dots = ""
	for i in range(int(current_time * 2) % 4):
		dots += "."
	loading_label.text = loading_stages[loading_stage] + dots
	
	# Change tips periodically
	if tip_change_time >= tip_duration:
		tip_change_time = 0.0
		current_tip = (current_tip + 1) % loading_tips.size()
		tip_label.text = loading_tips[current_tip]
		_start_tip_animation()
	
	# When loading is complete, transition to main menu
	if current_time >= loading_time:
		_transition_to_main_menu()

func _start_title_animation():
	# Create a tween for title animation
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(title_label, "modulate:a", 0.7, 1.5)
	tween.tween_property(title_label, "modulate:a", 1.0, 1.5)

func _start_subtitle_animation():
	# Create a tween for subtitle animation
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(subtitle_label, "modulate:a", 0.5, 2.0)
	tween.tween_property(subtitle_label, "modulate:a", 1.0, 2.0)

func _start_background_animation():
	# Create a subtle background color animation
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(background, "color", Color(0.8, 0.1, 0.5, 1), 3.0)
	tween.tween_property(background, "color", Color(0.95, 0.0, 0.66, 1), 3.0)

func _start_tip_animation():
	# Fade out current tip
	var tween = create_tween()
	tween.tween_property(tip_label, "modulate:a", 0.0, 0.3)
	tween.tween_callback(_update_tip_text)
	tween.tween_property(tip_label, "modulate:a", 1.0, 0.3)

func _update_tip_text():
	tip_label.text = loading_tips[current_tip]

func _play_loading_music():
	# Try to load and play loading music if it exists
	var music_path = "res://audio/music/loading_music.ogg"
	if ResourceLoader.exists(music_path):
		var music = load(music_path)
		AudioManager.play_music(music, true)

func _transition_to_main_menu():
	# Create a fade out effect before transitioning
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.tween_callback(func(): SceneManager.change_scene("res://scenes/main_menu.tscn"))
