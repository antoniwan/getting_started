extends Node

# Scene Manager Singleton
# Handles scene transitions and loading

func change_scene(path: String):
	# Use Godot's built-in scene changing method
	get_tree().change_scene_to_file(path) 
