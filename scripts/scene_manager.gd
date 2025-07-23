extends Node

# Scene Manager Singleton
# Handles scene transitions and loading

var transition_scene: Control
var is_transitioning = false

func _ready():
	# Create transition overlay
	transition_scene = Control.new()
	transition_scene.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	transition_scene.z_index = 1000
	transition_scene.modulate.a = 0.0
	
	var background = ColorRect.new()
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.color = Color.BLACK
	transition_scene.add_child(background)
	
	# Add to scene tree
	get_tree().root.add_child(transition_scene)

func change_scene(path: String, fade_duration: float = 0.5):
	if is_transitioning:
		return
	
	is_transitioning = true
	
	# Fade in
	var tween = create_tween()
	tween.tween_property(transition_scene, "modulate:a", 1.0, fade_duration)
	tween.tween_callback(func(): _perform_scene_change(path))
	tween.tween_property(transition_scene, "modulate:a", 0.0, fade_duration)
	tween.tween_callback(func(): is_transitioning = false)

func _perform_scene_change(path: String):
	# Use Godot's built-in scene changing method
	get_tree().change_scene_to_file(path)

# Legacy method for backward compatibility
func change_scene_immediate(path: String):
	get_tree().change_scene_to_file(path) 
