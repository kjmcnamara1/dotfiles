-- Pull in the wezterm API
local wezterm = require("wezterm")
-- local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

-- Session
-- config.default_prog = { "wsl", "--cd", "~" }
-- wezterm.on("gui-startup", function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or { position = { x = 100, y = 300, origin = "ActiveScreen" } })
--   window:gui_window():maximize()
-- end)

-- Theme
config.color_scheme = "nord" -- alt: kanagawa
-- config.color_scheme = "Catppuccin Frappe"
config.default_cursor_style = "SteadyBlock"

-- Window Settings
-- config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 }

config.initial_rows = 30
config.initial_cols = 120
config.scrollback_lines = 5000
config.enable_scroll_bar = true

-- config.window_background_opacity = 0.75
-- config.win32_system_backdrop = "Acrylic"

-- Tab Bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 40
config.switch_to_last_active_tab_when_closing_tab = true
config.hide_tab_bar_if_only_one_tab = true

-- config.window_frame = {
--   font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }), -- The font used in the tab bar.
--   font_size = 12,                                                      -- The size of the font in the tab bar.
-- }

-- Font Settings
config.font_size = 14
config.line_height = 1.2
config.adjust_window_size_when_changing_font_size = false
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

-- config.font_rules = {
--   {
--     italic = true,
--     intensity = "Bold",
--     font = wezterm.font({
--       family = "VictorMono Nerd Font",
--       weight = "Bold",
--       style = "Italic",
--     }),
--   },
--   {
--     italic = true,
--     intensity = "Half",
--     font = wezterm.font({
--       family = "VictorMono Nerd Font",
--       weight = "Thin",
--       style = "Italic",
--     }),
--   },
--   {
--     italic = true,
--     intensity = "Normal",
--     font = wezterm.font({
--       family = "VictorMono Nerd Font",
--       weight = "Regular",
--       style = "Italic",
--     }),
--   },
--   -- {
--   --   intensity = "Bold",
--   --   font = wezterm.font({
--   --     family = "VictorMono Nerd Font",
--   --     weight = "Bold",
--   --   }),
--   -- },
-- }


-- Neovim Zen Mode
wezterm.on("user-var-changed", function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while (number_value > 0) do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

-- Keybindings
config.enable_kitty_keyboard = true -- Enable kitty keyboard protocol
config.use_dead_keys = false        -- disable international accent keys for diacritics
-- config.disable_default_key_bindings = true
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  -- { key = "Enter", mods = "ALT",        action = act.ToggleFullScreen },
  -- { key = "C",     mods = "SHIFT|CTRL", action = act.CopyTo "Clipboard" },
  { key = "F11", mods = "SHIFT|CTRL", action = act.ToggleFullScreen },
  { key = "F5",  mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
  { key = "v",   mods = "LEADER",     action = act.SplitHorizontal },
  { key = "s",   mods = "LEADER",     action = act.SplitVertical },
}

-- Change mouse scroll amount
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = "NONE",
    action = act.ScrollByLine(-3),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = "NONE",
    action = act.ScrollByLine(3),
  },
}

-- Navigation with Nvim
smart_splits.apply_to_config(config, {
  -- directional keys to use in order of: left, down, up, right
  direction_keys = { "h", "j", "k", "l" },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = "CTRL",   -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "META", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

-- and finally, return the configuration to wezterm
return config
