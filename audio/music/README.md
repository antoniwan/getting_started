# Background Music

This directory is for your game's background music files.

## Supported Formats

- `.ogg` (recommended for best compression)
- `.wav` (uncompressed, larger file size)
- `.mp3` (compressed, widely supported)

## Usage

1. Place your music files in this directory
2. In your scripts, load and play them using:
   ```gdscript
   var music = load("res://audio/music/your_music.ogg")
   AudioManager.play_music(music)
   ```

## Recommended Structure

- `menu_music.ogg` - Music for main menu
- `game_music.ogg` - Music for gameplay
- `loading_music.ogg` - Music for loading screen

## Tips

- Keep file sizes reasonable (under 5MB per track)
- Use .ogg format for best compression
- Consider creating different versions for different game states
- Test volume levels to ensure they don't overpower sound effects
