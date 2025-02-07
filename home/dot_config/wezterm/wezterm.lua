-- Pull in the wezterm API
local wezterm = require("wezterm")
-- local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

local function is_windows()
  return wezterm.target_triple:find("windows") ~= nil
end

-- Session
if is_windows() then
  config.default_prog = { "xonsh" }
end
-- config.default_prog = { "wsl", "--cd", "~" }
-- wezterm.on("gui-startup", function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or { position = { x = 100, y = 300, origin = "ActiveScreen" } })
--   window:gui_window():maximize()
-- end)

-- Neovim Zen Mode
wezterm.on("user-var-changed", function(window, pane, name, value)
  wezterm.log_info("user-var-changed", name, value, window, pane)
  if name == "ZEN_MODE" then
    local overrides = window:get_config_overrides() or {}
    local incremental = value:find("+")
    local number_value = tonumber(value)
    local disable = number_value < 0
    wezterm.log_info("incremental", incremental)
    wezterm.log_info("number_value", number_value)
    wezterm.log_info("disable", disable)

    -- window:toggle_fullscreen()

    if disable then
      window:restore()
      window:perform_action(wezterm.action.SetPaneZoomState(false), pane)
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      if incremental ~= nil then
        while (number_value > 0) do
          window:perform_action(wezterm.action.IncreaseFontSize, pane)
          number_value = number_value - 1
        end
      else
        overrides.font_size = number_value
      end
      overrides.enable_tab_bar = false
      window:perform_action(wezterm.action.SetPaneZoomState(true), pane)
      window:maximize()
    end

    window:set_config_overrides(overrides)
  end
end)

-- Theme
config.color_scheme = "nord" -- alt: kanagawa
-- config.color_scheme = "Catppuccin Frappe"
config.default_cursor_style = "SteadyBlock"

-- Window Settings
config.window_decorations = is_windows() and "TITLE|RESIZE" or "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 }

config.initial_rows = 30
config.initial_cols = 120
config.scrollback_lines = 10000
config.enable_scroll_bar = false

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
  "JetBrainsMono Nerd Font",
  "Symbols Nerd Font",
  "Font Awesome 6 Free",
  "Noto Color Emoji",
})



-- Keybindings
config.enable_kitty_keyboard = true -- Enable kitty keyboard protocol
config.use_dead_keys = false        -- disable international accent keys for diacritics
-- config.disable_default_key_bindings = true
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  -- { key = "Enter", mods = "ALT",        action = act.DisableDefaultAssignment },
  -- { key = "Enter", mods = "ALT",        action = act.ToggleFullScreen },
  -- { key = "C",     mods = "SHIFT|CTRL", action = act.CopyTo "Clipboard" },
  { key = "v",   mods = "SHIFT|CTRL", action = act.PasteFrom "Clipboard" },
  { key = "F11", mods = "SHIFT|CTRL", action = act.ToggleFullScreen },
  { key = "F5",  mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
  { key = "v",   mods = "LEADER",     action = act.SplitHorizontal },
  { key = "s",   mods = "LEADER",     action = act.SplitVertical },
  { key = "j",   mods = "LEADER",     action = act.ScrollToPrompt(1) },
  { key = "k",   mods = "LEADER",     action = act.ScrollToPrompt(-1) },
  { key = "g",   mods = "LEADER",     action = act.ScrollToTop },
  { key = "G",   mods = "LEADER",     action = act.ScrollToBottom },
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
    move = "CTRL",        -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = "META|CTRL", -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

-- and finally, return the configuration to wezterm
return config
