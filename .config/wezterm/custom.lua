-- This is the entry point for custom configuration in WezTerm
local wezterm = require 'wezterm';
local os = require 'os';
local custom_config = {}

-- Config Values
local opacity = 0.75
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

function custom_config.apply(config)
    -- Appearance / Colours
    config.colors = require("themes/cyberdream")
    config.force_reverse_video_cursor = true

    -- Font
    config.font = wezterm.font("JetBrains Mono")
    config.font_size = 10.0

    -- Window
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = true
    config.show_tab_index_in_tab_bar = false
    config.colors.tab_bar = {
        background = transparent_bg,
        new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
        new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
    }

    wezterm.on("format-tab-title", function(tab, _, _, _, hover)
        local background = config.colors.brights[1]
        local foreground = config.colors.foreground

        if tab.is_active then
            background = config.colors.brights[7]
            foreground = config.colors.background
        elseif hover then
            background = config.colors.brights[8]
            foreground = config.colors.background
        end

        local title = tostring(tab.tab_index + 1)
        return {
            { Foreground = { Color = background } },
            { Text = "█" },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Foreground = { Color = background } },
            { Text = "█" },
        }
    end)

    -- Launcher Menu
    -- TODO: This should be dynamic to the OS
    config.launch_menu = {
        -- Powershell
        { label = "Powershell", args = { "powershell.exe", '-NoLogo' } },
    }

    -- Behaviour
    -- TODO: This should be dynamic to the OS and also check what WSL distro is installed
    config.default_prog = { "C:\\Windows\\system32\\wsl.exe", "-d", "Arch" }

    config.window_decorations = "RESIZE"
    config.window_background_opacity = opacity
    config.win32_system_backdrop = "Acrylic"

    config.max_fps = 144
    config.animation_fps = 60
    config.cursor_blink_rate = 250

    -- Keybindings
    config.keys = {
        -- Remap Copy and Paste
        { key = "c", mods = "CTRL", action = wezterm.action({ CopyTo = "Clipboard" }) },
        { key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
        -- Launcher Menu
        { key = " ", mods = "CTRL", action = wezterm.action.ShowLauncher },

        -- Window
    }
end

return custom_config
