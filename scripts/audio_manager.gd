extends Node

# Audio Manager Singleton
# Handles background music and sound effects

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

var current_music: AudioStream
var music_volume: float = 0.5
var sfx_volume: float = 0.7

func _ready():
	# Create music player
	music_player = AudioStreamPlayer.new()
	music_player.name = "MusicPlayer"
	music_player.volume_db = linear_to_db(music_volume)
	add_child(music_player)
	
	# Create SFX player
	sfx_player = AudioStreamPlayer.new()
	sfx_player.name = "SFXPlayer"
	sfx_player.volume_db = linear_to_db(sfx_volume)
	add_child(sfx_player)

func play_music(stream: AudioStream, fade_in: bool = true):
	if current_music == stream and music_player.playing:
		return
	
	current_music = stream
	music_player.stream = stream
	
	if fade_in:
		music_player.volume_db = linear_to_db(0.0)
		music_player.play()
		
		var tween = create_tween()
		tween.tween_property(music_player, "volume_db", linear_to_db(music_volume), 1.0)
	else:
		music_player.volume_db = linear_to_db(music_volume)
		music_player.play()

func stop_music(fade_out: bool = true):
	if not music_player.playing:
		return
	
	if fade_out:
		var tween = create_tween()
		tween.tween_property(music_player, "volume_db", linear_to_db(0.0), 1.0)
		tween.tween_callback(music_player.stop)
	else:
		music_player.stop()

func play_sfx(stream: AudioStream):
	sfx_player.stream = stream
	sfx_player.play()

func set_music_volume(volume: float):
	music_volume = clamp(volume, 0.0, 1.0)
	if music_player.playing:
		music_player.volume_db = linear_to_db(music_volume)

func set_sfx_volume(volume: float):
	sfx_volume = clamp(volume, 0.0, 1.0)
	sfx_player.volume_db = linear_to_db(sfx_volume) 
