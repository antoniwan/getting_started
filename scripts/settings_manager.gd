extends Node

# Settings Manager Singleton
# Handles game settings and configuration

signal settings_changed

var settings_file = "user://settings.cfg"
var config = ConfigFile.new()

# Default settings
var default_settings = {
	"audio": {
		"music_volume": 0.5,
		"sfx_volume": 0.7,
		"master_volume": 1.0
	},
	"game": {
		"fullscreen": false,
		"vsync": true,
		"loading_time": 3.0
	},
	"ui": {
		"show_tips": true,
		"show_version": true
	}
}

func _ready():
	load_settings()

func load_settings():
	# Load settings from file
	var error = config.load(settings_file)
	if error != OK:
		# File doesn't exist, create with defaults
		create_default_settings()
		return
	
	# Apply loaded settings
	apply_settings()

func save_settings():
	# Save current settings to file
	var error = config.save(settings_file)
	if error != OK:
		print("Error saving settings: ", error)

func create_default_settings():
	# Create default settings
	for section in default_settings:
		for key in default_settings[section]:
			config.set_value(section, key, default_settings[section][key])
	
	save_settings()
	apply_settings()

func apply_settings():
	# Apply audio settings
	if AudioManager:
		AudioManager.set_music_volume(get_setting("audio", "music_volume"))
		AudioManager.set_sfx_volume(get_setting("audio", "sfx_volume"))
		# Apply master volume if AudioManager supports it
		var master_volume = get_setting("audio", "master_volume", 1.0)
		if AudioManager.has_method("set_master_volume"):
			AudioManager.set_master_volume(master_volume)
	
	# Apply display settings
	if get_setting("game", "fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	# Apply vsync
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if get_setting("game", "vsync") else DisplayServer.VSYNC_DISABLED)
	
	# Emit signal
	settings_changed.emit()

func get_setting(section: String, key: String, default = null):
	if config.has_section_key(section, key):
		return config.get_value(section, key)
	return default if default != null else default_settings[section][key]

func set_setting(section: String, key: String, value):
	config.set_value(section, key, value)
	save_settings()
	apply_settings()

func reset_to_defaults():
	# Reset all settings to defaults
	for section in default_settings:
		for key in default_settings[section]:
			config.set_value(section, key, default_settings[section][key])
	
	save_settings()
	apply_settings()

# Convenience methods for common settings
func get_music_volume() -> float:
	return get_setting("audio", "music_volume")

func set_music_volume(volume: float):
	set_setting("audio", "music_volume", volume)

func get_sfx_volume() -> float:
	return get_setting("audio", "sfx_volume")

func set_sfx_volume(volume: float):
	set_setting("audio", "sfx_volume", volume)

func get_loading_time() -> float:
	return get_setting("game", "loading_time")

func set_loading_time(time: float):
	set_setting("game", "loading_time", time)

func get_master_volume() -> float:
	return get_setting("audio", "master_volume", 1.0)

func set_master_volume(volume: float):
	set_setting("audio", "master_volume", volume)

func is_fullscreen() -> bool:
	return get_setting("game", "fullscreen")

func set_fullscreen(enabled: bool):
	set_setting("game", "fullscreen", enabled) 
