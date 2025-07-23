# Sound Effects

This directory is for your game's sound effect files.

## Supported Formats

- `.ogg` (recommended for best compression)
- `.wav` (uncompressed, larger file size)
- `.mp3` (compressed, widely supported)

## Usage

1. Place your sound effect files in this directory
2. In your scripts, load and play them using:
   ```gdscript
   var sfx = load("res://audio/sfx/your_sound.ogg")
   AudioManager.play_sfx(sfx)
   ```

## Recommended Structure

- `button_click.ogg` - Button press sounds
- `menu_select.ogg` - Menu selection sounds
- `game_start.ogg` - Game start sound
- `transition.ogg` - Scene transition sound

## Tips

- Keep sound effects short and impactful
- Use .ogg format for best compression
- Name files descriptively
- Consider creating variations for different actions
- Test volume levels to ensure they work well with music
