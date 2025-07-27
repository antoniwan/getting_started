extends CharacterBody2D

@export var speed = 50.0
@export var patrol_distance = 100.0

var start_position: Vector2
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	start_position = position

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Patrol movement
	velocity.x = speed * direction
	
	# Check if we need to turn around
	if position.x > start_position.x + patrol_distance:
		direction = -1
	elif position.x < start_position.x - patrol_distance:
		direction = 1
	
	# Move the enemy
	move_and_slide()
	
	# Check for collision with player
	_check_player_collision()

func _check_player_collision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		
		if body.name == "Player":
			_damage_player(body)

func _damage_player(player):
	# Damage the player
	print("Player hit by enemy!")
	
	# Play damage sound if available
	_play_damage_sound()
	
	# Damage the player
	if player.has_method("take_damage"):
		player.take_damage(20)  # Deal 20 damage
	
	# Push the player back
	player.velocity.x = direction * 200
	player.velocity.y = -100

func _play_damage_sound():
	# Try to play damage sound if available
	var damage_sound_path = "res://audio/sfx/damage.ogg"
	if ResourceLoader.exists(damage_sound_path):
		var damage_sound = load(damage_sound_path)
		AudioManager.play_sound(damage_sound) 