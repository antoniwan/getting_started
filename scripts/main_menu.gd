extends Control

@onready var new_game_button = $VBoxContainer/NewGameButton
@onready var quit_button = $VBoxContainer/QuitButton

func _ready():
	# Connect button signals
	new_game_button.pressed.connect(_on_new_game_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_new_game_pressed():
	# Transition to the game scene
	SceneManager.change_scene("res://scenes/game.tscn")

func _on_quit_pressed():
	# Quit the game
	get_tree().quit() 
