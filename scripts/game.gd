extends Node2D

func _ready():
	# Initialize the game scene
	print("Game scene loaded - ready for your game content!")

func _input(event):
	# Handle input for the game scene
	if event.is_action_pressed("ui_cancel"):
		# Return to main menu when Escape is pressed
		SceneManager.change_scene("res://scenes/main_menu.tscn") 
