-- Pull in the wezterm API
local wezterm = require("wezterm")
-- local mux = wezterm.mux
local act = wezterm.action

-- wezterm.on("gui-startup", function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_prog = { "wsl", "--cd", "~" }
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
  left = "1cell",
  right = "1cell",
  top = 0,
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
-- config.tab_bar_at_bottom = true
config.tab_max_width = 40
config.switch_to_last_active_tab_when_closing_tab = true
config.hide_tab_bar_if_only_one_tab = true

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
}

config.color_scheme = "nord"
config.font = wezterm.font_with_fallback({
  -- {
  --   family = "VictorMono Nerd Font",
  --   weight = "Medium",
  --   harfbuzz_features = {
  --     "ss06", -- slashed 7
  --     "ss07", -- straighter 6 and 9
  --     "ss08", -- turbofish ::<
  --   },
  -- },
  -- {
  --   family = "FiraCode Nerd Font",
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
  -- "Fira Code Script", -- Fira Code with cursive Italics but no ligatures
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
  "JetBrainsMono Nerd Font",
  "Symbols Nerd Font",
})

config.font_rules = {
  {
    italic = true,
    intensity = "Bold",
    font = wezterm.font({
      family = "VictorMono Nerd Font",
      weight = "Bold",
      style = "Italic",
    }),
  },
  {
    italic = true,
    intensity = "Half",
    font = wezterm.font({
      family = "VictorMono Nerd Font",
      weight = "Thin",
      style = "Italic",
    }),
  },
  {
    italic = true,
    intensity = "Normal",
    font = wezterm.font({
      family = "VictorMono Nerd Font",
      weight = "Regular",
      style = "Italic",
    }),
  },
  -- {
  --   intensity = "Bold",
  --   font = wezterm.font({
  --     family = "VictorMono Nerd Font",
  --     weight = "Bold",
  --   }),
  -- },
}

config.font_size = 14
config.line_height = 1.2

config.use_dead_keys = false
config.scrollback_lines = 5000

-- config.enable_scroll_bar = true

config.adjust_window_size_when_changing_font_size = false
config.default_cursor_style = "SteadyBlock"

-- config.disable_default_key_bindings = true

-- config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "Enter", mods = "ALT",        action = act.ToggleFullScreen },
  { key = "C",     mods = "SHIFT|CTRL", action = act.CopyTo "Clipboard" },
  { key = "R",     mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
}

-- and finally, return the configuration to wezterm
return config
