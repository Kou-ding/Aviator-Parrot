# Aviator-Parrot
A flappy bird inspired godot game.

## Project Settings

For pixelated games:
```
Rendering > Textures > Default Texture Filter = Nearest 
```

For elements scalable with screen resolution:
```
Display > Window > Stretch > Mode = canvas_items
```
**Mode and Aspect are important settings for how the game plays**

To be able to full screen the game while windowed:
```
Top Bar > Game > Embedding options > Embed game on Next Play = off  
```

## Running html export locally

Run a simple http server on the export's directory
```bash
python -m http.server 
```