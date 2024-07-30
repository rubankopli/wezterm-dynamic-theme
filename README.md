<br />
<div align="center">
  <h1 align="center">Wezterm Dynamic Theme</h1>

  <p align="center">
    A dynamic wezterm theme using background layers to create a cool window and rain effect!
    <br />

  </p>
</div>

## Demo
https://github.com/user-attachments/assets/722a9ac2-0031-4a1d-a0d9-7a156ad8c835

## About
I couldn't find any wezterm configs that had a cool dynamic theme like I was looking for, so I decided to make my own! 
I borrowed heavily from the wezterm official documentation's [Parallax Example](https://wezfurlong.org/wezterm/config/lua/config/background.html#parallax-example) and edited an existing wallpaper image I found to break it into a few layers, which I could use with the wezterm configuration to bring my idea to life. The project uses a few different image layers with varying opacity and 'scroll speed' to give the impression of semi see-through window panes and rain. 

## Using The Theme

### Prerequisites
- [Wezterm](https://github.com/wez/wezterm)

### Setup
Setting up the theme should be quick and easy!
1. If you haven't set up your wezterm configuration file already, do so (I reccomend creating it in `~/.config/wezterm/wezterm.lua`) and add at least the following lines from the [quick start guide](https://wezfurlong.org/wezterm/config/files.html):
```lua
-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- and finally, return the configuration to wezterm
return config
```
3. Clone or download the repository to a location of your choosing
4. Move the `wezterm-background.lua` file as well as the whole `background_images` directory to the same directory as your `wezterm.lua` configuration file. Your wezterm config folder should look like this:
```
  ┆
  ├─ wezterm.lua
  └─ background_images
     ├─ city.png
     ├─ indoors.png
     ├─ rain_0.png
     ├─ rain_1.png
     ├─ rain_2.png
     ├─ trails_0.png
     └─ ...
```
3. Add the following lines to your main wezterm configuration file:
```lua
local dynamic_background = require 'wezterm-background'
dynamic_background.apply_to_config(config)
```
**And thats it! You should be good to go!**

### Customizing the Theme
A few parameters are provided at the top of the `wezterm-background.lua` file to allow you to adjust various aspects of the theme. Official documentation on the wezterm background parameters can be found at the [official documentation page](https://wezfurlong.org/wezterm/config/lua/config/background.html) for wezterm's background configuration.
The 'dimmer' options correspond to the `hsb` option for a background layer.
The 'opacity' options correspond to the option of the same name for a background layer.
The 'parallax_scaling_factor' simply multiplies the parallax 'scrolling speed' for all the scrolling layers by the value given. The other values set the base 'scrolling speed'. All of the values correspond to the `parallax` option inside the `attachment` option for a background layer.


---

*Distributed under the MIT License. See `LICENSE.txt` for more information.*


