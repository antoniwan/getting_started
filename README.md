# Godot Game Template

A clean, minimal Godot 4.4 game template with loading screen, main menu, and game scene structure. Perfect for starting new game projects with a professional foundation.

## Project Overview

This template provides a solid foundation for game development with:

- **Loading Screen**: Professional loading animation with progress bar
- **Main Menu**: Clean interface with New Game and Quit options
- **Game Scene**: Empty game scene ready for your content
- **Scene Management**: Automatic scene transitions via singleton

## Features

- **Professional Loading Screen**: Shows game title and animated loading progress
- **Main Menu System**: Simple and clean menu interface
- **Scene Transitions**: Smooth scene management between screens
- **Input Handling**: Escape key returns to main menu from game
- **Responsive Design**: Works with different window sizes
- **Clean Architecture**: Minimal, well-organized code structure

## File Structure

```
getting_started/
├── scenes/
│   ├── loading_screen.tscn    # Initial loading screen with credits
│   ├── main_menu.tscn         # Main menu with New Game/Quit options
│   └── game.tscn              # Empty game scene for your content
├── scripts/
│   ├── scene_manager.gd       # Singleton for scene transitions
│   ├── loading_screen.gd      # Loading screen logic and animation
│   ├── main_menu.gd           # Main menu button handling
│   └── game.gd                # Game scene initialization
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

1. **Loading Screen** (3 seconds):

   - Shows game title and animated loading progress
   - Automatically transitions to main menu

2. **Main Menu**:

   - **New Game**: Starts the game scene
   - **Quit**: Exits the application

3. **Game Scene**:
   - Empty scene ready for your game content
   - Press **Escape** to return to main menu

## Customization

### Changing Game Title

Edit the title in `scenes/loading_screen.tscn` and `scenes/main_menu.tscn`

### Loading Time

Modify `loading_time` variable in `scripts/loading_screen.gd`

### Colors and Styling

Update the ColorRect colors in each scene file

### Adding New Scenes

1. Create new scene files in the `scenes/` folder
2. Add corresponding scripts in the `scripts/` folder
3. Use `SceneManager.change_scene("path/to/scene.tscn")` to transition

## Requirements

- **Godot Engine 4.4** or later
- No additional dependencies required

## Development Tips

- The `SceneManager` singleton handles all scene transitions
- Each scene has its own script for specific functionality
- The template uses Control nodes for UI scenes and Node2D for game scenes
- Input handling is set up for basic navigation (Escape key)
- All scripts are minimal and well-commented for easy modification

## Next Steps

After setting up this template:

1. Add your game content to the `game.tscn` scene
2. Create additional scenes for different game states
3. Add sound effects and music
4. Implement save/load functionality
5. Add settings menu and other UI elements

## Resources

- [Godot Documentation](https://docs.godotengine.org/)
- [Godot Tutorials](https://docs.godotengine.org/en/stable/tutorials/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)

## License

This template is open source and follows the same license as the Godot Engine.
