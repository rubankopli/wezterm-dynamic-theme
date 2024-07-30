-- Pull in the wezterm API --
local wezterm = require 'wezterm'

------------------------------
-- Background Configuration --
------------------------------

-- Control the dimness of the background images
local background_dimmer = { brightness = 0.2 }
local background_rain_dimmer = { brightness = 0.2 }
local background_trails_dimmer = { brightness = 0.3 }

-- opacity of the different layers
local background_window_opacity = 0.8
local background_window_water_trail_opacity = 0.5
local background_rain_opacity = 0.4
local background_indoor_opacity = 1.0

-- 'scrolling speed' adjustment for the layers
local parallax_scaling_factor = 1.0 -- multiplies the speed of all layers
local trails_parallax = -0.05
local rain_0_parallax = -0.5
local rain_1_parallax = -0.6
local rain_2_parallax = -0.7


---------------
-- Constants --
---------------

-- Path where the background images are stored
local background_image_path = wezterm.config_dir .. '/background_images/'

-- Adjust the scaling strategy and repeat for the background images
local background_height = '100%'
local background_width = '100%'
local background_repeat_y_size = '100%'
local offset = '-100%'




----------------------
-- Helper Functions --
----------------------

-- Create a background layer, using default options unless overridden
local function create_layer(file, options)
    options = options or {}

    local layer = {
        source = { File = background_image_path .. file },

        height = background_height,
        width = background_width,

        hsb = options.hsb or background_dimmer,
        opacity = options.opacity or background_rain_opacity,
    }

    -- Only set these if the layer is 'scrolling'
    if options.parallax then
        layer.repeat_y_size = background_repeat_y_size
        layer.attachment = { Parallax = options.parallax * parallax_scaling_factor }
        if options.vertical_offset then layer.vertical_offset = options.vertical_offset end
    end

    return layer
end

-- Create layers using the defaults for the water trails
local function create_trails_layer(options)
    local file = 'trails_0.png'

    options = options or {}
    options.parallax = trails_parallax
    options.opacity = background_window_water_trail_opacity
    options.hsb = background_trails_dimmer

    return create_layer(file, options)
end

-- Create layers using the defaults for the rain
local function create_rain_layer(file, options) -- options.parallax should be provided
    options.opacity = background_rain_opacity
    options.hsb = background_rain_dimmer

    return create_layer(file, options)
end

-----------------------
-- Background Module --
-----------------------

-- The module table that we will export to the config file
local module = {}

function module.apply_to_config(config)
    config.background =
    {
        -- back-most layer. Will be rendered first (outdoors/window)
        create_layer('city.png', { opacity = background_window_opacity }),
        -- middle layers - rain
        -- These two 'trails' layers fall slower - like rain sliding down your window pane
        create_trails_layer(),
        create_trails_layer({ vertical_offset = '-100%' }),
        -- These rain layers should be falling faster in the background
        create_rain_layer('rain_0.png', { parallax = rain_0_parallax }),
        create_rain_layer('rain_0.png', { parallax = rain_0_parallax, vertical_offset = '-100%' }),
        create_rain_layer('rain_1.png', { parallax = rain_1_parallax }),
        create_rain_layer('rain_1.png', { parallax = rain_1_parallax, vertical_offset = '-100%' }),
        create_rain_layer('rain_2.png', { parallax = rain_2_parallax }),
        create_rain_layer('rain_2.png', { parallax = rain_2_parallax, vertical_offset = '-100%' }),
        -- final topmost layer (indoors)
        create_layer('indoors.png', { opacity = background_indoor_opacity }),
    }
end

return module
