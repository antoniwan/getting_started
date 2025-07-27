extends Area2D

signal coin_collected

var collected = false

func _ready():
	# Connect the body entered signal
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Coin ", name, " detected collision with: ", body.name)
	if body.name == "Player" and not collected:
		print("Collecting coin: ", name)
		collect()

func collect():
	if collected:
		print("Coin ", name, " already collected, ignoring")
		return
		
	print("Collecting coin: ", name)
	collected = true
	
	# Play coin collection sound
	_play_coin_sound()
	
	# Emit signal for score tracking
	print("Emitting coin_collected signal for: ", name)
	coin_collected.emit()
	
	# Create a simple collection effect
	_create_collection_effect()
	
	# Remove the coin from the scene
	print("Removing coin from scene: ", name)
	queue_free()

func _play_coin_sound():
	# Try to play coin sound if available
	var coin_sound_path = "res://audio/sfx/coin.ogg"
	if ResourceLoader.exists(coin_sound_path):
		var coin_sound = load(coin_sound_path)
		AudioManager.play_sound(coin_sound)

func _create_collection_effect():
	# Create a simple particle effect or animation
	var effect = ColorRect.new()
	effect.color = Color(1, 1, 0, 1)
	effect.size = Vector2(16, 16)
	effect.position = position - Vector2(8, 8)
	get_parent().add_child(effect)
	
	# Animate the effect
	var tween = create_tween()
	tween.tween_property(effect, "scale", Vector2(2, 2), 0.3)
	tween.parallel().tween_property(effect, "modulate:a", 0.0, 0.3)
	tween.tween_callback(effect.queue_free) 