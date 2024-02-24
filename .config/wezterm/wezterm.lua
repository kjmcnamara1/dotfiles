-- Pull in the wezterm API
local wezterm = require("wezterm")
-- local mux = wezterm.mux
-- local act = wezterm.action

-- wezterm.on("gui-startup", function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_prog = { "nu" }
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
  left = "1cell",
  right = "1cell",
  top = ".5cell",
  bottom = 0
}
config.window_close_confirmation = "NeverPrompt"

config.window_background_opacity = 0.75
config.win32_system_backdrop = "Acrylic"

config.initial_rows = 20
config.initial_cols = 120

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

-- config.use_fancy_tab_bar = false
config.tab_max_width = 40
config.tab_bar_at_bottom = true
config.switch_to_last_active_tab_when_closing_tab = true

config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 12,
  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = "#333333",
  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = "#333333",
}

config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = "#0b0022",
    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = "#2b2042",
      -- The color of the text for the tab
      fg_color = "#c0c0c0",
      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = "Normal",
      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = "None",
      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,
      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },
    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = "#1b1032",
      fg_color = "#808080",
      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },
    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = "#3b3052",
      fg_color = "#909090",
      italic = true,
      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },
    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = "#1b1032",
      fg_color = "#808080",
      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },
    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = "#3b3052",
      fg_color = "#909090",
      italic = true,
      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}

config.color_scheme = "nord"
config.font = wezterm.font_with_fallback({
  -- "Fira Code Script", -- Fira Code with cursive Italics but no ligatures
  -- {
  --   family = "Fira Code",
  --   harfbuzz_features = {
  --     "zero", -- dotted 0
  --     "onum", -- offset number heights
  --     "cv30", -- taller |
  --     "cv31", -- rounder ()
  --     "cv25", -- aligned .-
  --     "cv26", -- aligned :-
  --     "cv32", -- aligned .=
  --     "cv28", -- aligned {. .}
  --     "ss07", -- combined =~ and !~
  --   },
  -- },
  {
    family = "VictorMono Nerd Font",
    weight = "Medium",
    harfbuzz_features = {
      "ss06", -- slashed 7
      "ss07", -- straighter 6 and 9
      "ss08", -- turbofish ::<
    },
  },
  -- "JetBrains Mono",
  -- {
  --   family = "Cascadia Code",
  --   harfbuzz_features = {
  --     "ss01", -- cursive italics
  --     "ss02",
  --     "ss03",
  --     "ss20",
  --   },
  -- },
  -- {
  --   family = "Iosevka Nerd Font",
  --   harfbuzz_features = {
  --     "PHPX", -- symbol ligatures
  --   },
  -- },
  -- "IosevkaTerm Nerd Font",
  "Symbols Nerd Font",
})

config.font_rules = {
  -- {
  --   italic = true,
  --   intensity = "Bold",
  --   font = wezterm.font({
  --     family = "VictorMono Nerd Font",
  --     weight = "Bold",
  --     style = "Italic",
  --   }),
  -- },
  -- {
  --   italic = true,
  --   intensity = "Half",
  --   font = wezterm.font({
  --     family = "VictorMono Nerd Font",
  --     weight = "Thin",
  --     style = "Italic",
  --   }),
  -- },
  -- {
  --   italic = true,
  --   intensity = "Normal",
  --   font = wezterm.font({
  --     family = "VictorMono Nerd Font",
  --     weight = "Regular",
  --     style = "Italic",
  --   }),
  -- },
  {
    -- italic = false,
    intensity = "Bold",
    font = wezterm.font({
      family = "VictorMono Nerd Font",
      weight = "Bold",
    }),
  },
  -- {
  --   italic = false,
  --   intensity = "Half",
  --   font = wezterm.font({
  --     family = "VictorMono Nerd Font",
  --     weight = "Light",
  --   }),
  -- },
}

config.font_size = 16
config.line_height = 1.2

config.use_dead_keys = false
config.scrollback_lines = 5000

-- config.enable_scroll_bar = true

config.adjust_window_size_when_changing_font_size = false
-- config.hide_tab_bar_if_only_one_tab = true

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- and finally, return the configuration to wezterm
return config
