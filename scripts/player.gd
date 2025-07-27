extends CharacterBody2D

# Player movement variables
@export var speed = 300.0
@export var jump_velocity = -400.0
@export var acceleration = 1500.0
@export var friction = 1200.0

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Camera reference
@onready var camera = get_parent().get_node("Camera2D")

# Player state
var can_double_jump = false
var has_double_jump = false
var is_invulnerable = false
var invulnerability_time = 1.0

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Reset double jump when on floor
		has_double_jump = false
		can_double_jump = true

	# Handle jump
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = jump_velocity
			has_double_jump = true
			_play_jump_sound()
		elif has_double_jump and can_double_jump:
			velocity.y = jump_velocity * 0.8
			has_double_jump = false
			_play_jump_sound()

	# Get the input direction and handle the movement/deceleration
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	move_and_slide()
	
	# Update camera to follow player
	_update_camera()

func _update_camera():
	if camera:
		# Smooth camera following
		var target_position = position
		camera.position = camera.position.lerp(target_position, 0.1)
		
		# Keep camera within reasonable bounds
		camera.position.x = clamp(camera.position.x, 100, 1500)
		camera.position.y = clamp(camera.position.y, 200, 500)

func _play_jump_sound():
	# Try to play jump sound if available
	var jump_sound_path = "res://audio/sfx/jump.ogg"
	if ResourceLoader.exists(jump_sound_path):
		var jump_sound = load(jump_sound_path)
		AudioManager.play_sound(jump_sound)

func take_damage():
	if is_invulnerable:
		return
		
	print("Player took damage!")
	is_invulnerable = true
	
	# Play damage sound
	_play_damage_sound()
	
	# Visual feedback (flash effect)
	_create_damage_effect()
	
	# Reset invulnerability after time
	await get_tree().create_timer(invulnerability_time).timeout
	is_invulnerable = false

func _play_damage_sound():
	# Try to play damage sound if available
	var damage_sound_path = "res://audio/sfx/damage.ogg"
	if ResourceLoader.exists(damage_sound_path):
		var damage_sound = load(damage_sound_path)
		AudioManager.play_sound(damage_sound)

func _create_damage_effect():
	# Create a simple flash effect
	var sprite = $Sprite2D
	if sprite:
		var tween = create_tween()
		tween.tween_property(sprite, "modulate", Color.RED, 0.1)
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.1)
		tween.set_loops(3)

func _on_area_2d_body_entered(body):
	# Handle any special interactions (coins, enemies, etc.)
	if body.has_method("collect"):
		body.collect()
	elif body.has_method("damage"):
		body.damage() 