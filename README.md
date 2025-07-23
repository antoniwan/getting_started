# Godot Game Template

A clean, minimal Godot 4.4 game template with loading screen, main menu, and game scene structure. Perfect for starting new game projects with a professional foundation.

## Project Overview

This template provides a solid foundation for game development with:

- **Loading Screen**: Professional loading animation with progress bar
- **Main Menu**: Clean interface with New Game and Quit options
- **Game Scene**: Empty game scene ready for your content
- **Scene Management**: Automatic scene transitions via singleton

## Features

- **Enhanced Loading Screen**:
  - Professional loading animation with progress bar
  - Dynamic loading stages (Initializing, Loading Assets, etc.)
  - Rotating tips and helpful information
  - Version display
  - Smooth animations and transitions
  - Background color animation
  - Configurable loading time
- **Audio System**:
  - Background music support with fade in/out
  - Sound effects for UI interactions
  - Volume control for music and SFX
  - Automatic audio file detection
- **Settings Management**:
  - Persistent user settings
  - Audio volume controls
  - Display settings (fullscreen, vsync)
  - UI preferences (show/hide tips, version)
  - Configurable loading time
- **Main Menu System**: Simple and clean menu interface with audio feedback
- **Scene Transitions**: Smooth scene management with fade effects
- **Input Handling**: Escape key returns to main menu from game
- **Responsive Design**: Works with different window sizes
- **Clean Architecture**: Well-organized code structure with singletons

## File Structure

```
getting_started/
├── scenes/
│   ├── loading_screen.tscn    # Enhanced loading screen with tips and animations
│   ├── main_menu.tscn         # Main menu with New Game/Quit options
│   └── game.tscn              # Empty game scene for your content
├── scripts/
│   ├── scene_manager.gd       # Singleton for smooth scene transitions
│   ├── audio_manager.gd       # Singleton for audio management
│   ├── settings_manager.gd    # Singleton for user settings
│   ├── loading_screen.gd      # Enhanced loading screen logic
│   ├── main_menu.gd           # Main menu with audio feedback
│   └── game.gd                # Game scene initialization
├── audio/
│   ├── music/                 # Background music files
│   │   └── README.md          # Music usage instructions
│   └── sfx/                   # Sound effect files
│       └── README.md          # SFX usage instructions
├── project.godot              # Project configuration
├── icon.svg                   # Project icon
├── icon.svg.import           # Icon import settings
└── .gitignore                # Git ignore rules
```

## How to Use

1. **Download and Install Godot 4.4** from [godotengine.org](https://godotengine.org/download)
2. **Open the Project**:
   - Launch Godot Engine
   - Click "Import" or "Open"
   - Navigate to this project folder and select the `project.godot` file
3. **Run the Project**:
   - Press `F5` or click the "Play" button
   - You'll see the loading screen, then main menu, then game scene

## Game Flow

1. **Enhanced Loading Screen** (configurable, default 3 seconds):

   - Shows game title with breathing animation
   - Dynamic loading stages (Initializing → Loading Assets → Preparing Game → Almost Ready)
   - Rotating helpful tips and information
   - Version display
   - Smooth progress bar animation
   - Background color animation
   - Optional background music (if `loading_music.ogg` exists)
   - Fade transition to main menu

2. **Main Menu**:

   - **New Game**: Starts the game scene with button sound
   - **Quit**: Exits the application with button sound
   - Optional background music (if `menu_music.ogg` exists)

3. **Game Scene**:
   - Empty scene ready for your game content
   - Press **Escape** to return to main menu

## Customization

### Changing Game Title

Edit the title in `scenes/loading_screen.tscn` and `scenes/main_menu.tscn`

### Loading Time

Modify the loading time in settings or change `SettingsManager.get_loading_time()` in `scripts/loading_screen.gd`

### Audio

- Add `loading_music.ogg` to `audio/music/` for loading screen music
- Add `menu_music.ogg` to `audio/music/` for main menu music
- Add `button_click.ogg` to `audio/sfx/` for button sounds
- Audio files are automatically detected and played

### Settings

The game automatically saves user settings to `user://settings.cfg`:

- Audio volumes (music, SFX)
- Display settings (fullscreen, vsync)
- UI preferences (show/hide tips, version)
- Loading time

### Colors and Styling

Update the ColorRect colors in each scene file

### Adding New Scenes

1. Create new scene files in the `scenes/` folder
2. Add corresponding scripts in the `scripts/` folder
3. Use `SceneManager.change_scene("path/to/scene.tscn")` to transition

### Loading Tips

Edit the `loading_tips` array in `scripts/loading_screen.gd` to customize the rotating tips

## Requirements

- **Godot Engine 4.4** or later
- No additional dependencies required

## Development Tips

- **SceneManager**: Handles smooth scene transitions with fade effects
- **AudioManager**: Manages background music and sound effects with volume control
- **SettingsManager**: Handles persistent user settings and configuration
- Each scene has its own script for specific functionality
- The template uses Control nodes for UI scenes and Node2D for game scenes
- Input handling is set up for basic navigation (Escape key)
- All scripts are well-commented and follow Godot best practices
- Audio files are automatically detected - just add them to the appropriate folders
- Settings are automatically saved and loaded between sessions

## Next Steps

After setting up this template:

1. Add your game content to the `game.tscn` scene
2. Create additional scenes for different game states
3. Add sound effects and music to the `audio/` folders
4. Implement save/load functionality for game progress
5. Add a settings menu using the SettingsManager
6. Create additional UI elements and menus
7. Add particle effects and visual enhancements
8. Implement game-specific features and mechanics

## Resources

- [Godot Documentation](https://docs.godotengine.org/)
- [Godot Tutorials](https://docs.godotengine.org/en/stable/tutorials/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)

## License

This template is open source and follows the same license as the Godot Engine.
