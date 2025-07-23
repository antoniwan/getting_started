extends Control

@onready var progress_bar = $VBoxContainer/ProgressBar
@onready var loading_label = $VBoxContainer/LoadingLabel

var loading_time = 3.0  # Time in seconds to show loading screen
var current_time = 0.0

func _ready():
	# Initialize the loading screen
	progress_bar.value = 0
	loading_label.text = "Loading..."
	
	# Start the loading timer
	current_time = 0.0

func _process(delta):
	current_time += delta
	
	# Update progress bar
	var progress = (current_time / loading_time) * 100
	progress_bar.value = progress
	
	# Update loading text with dots animation
	var dots = ""
	for i in range(int(current_time * 2) % 4):
		dots += "."
	loading_label.text = "Loading" + dots
	
	# When loading is complete, transition to main menu
	if current_time >= loading_time:
		SceneManager.change_scene("res://scenes/main_menu.tscn")
