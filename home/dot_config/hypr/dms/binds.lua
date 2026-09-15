-- DMS default keybinds (Hyprland 0.55+ Lua)

hl.bind("SUPER + CTRL + I", hl.dsp.exec_cmd("dms ipc call inhibit toggle"), { description = "Idle Inhibit: Toggle" })
hl.bind("SUPER + ALT + C", hl.dsp.exec_cmd("dms color pick -a"), { description = "Pick Color" })

-- === Application Launchers ===
hl.bind("SUPER + Return", hl.dsp.exec_cmd("$TERMINAL"), { description = "Terminal: Launch" })
hl.bind("SUPER + ALT + Return", hl.dsp.exec_cmd("$TERMINAL -e herdr"), { description = "Terminal: Launch (herdr)" })
hl.bind("SUPER + Space", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind("ALT + Space", hl.dsp.exec_cmd("dms ipc call spotlight-bar toggle"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("dms ipc call defaultApp browser"))
hl.bind("SUPER + ALT + B", hl.dsp.exec_cmd("~/.local/bin/launch-browser --private"),
  { description = "Web Browser (Private)" })
hl.bind("SUPER + A", hl.dsp.exec_cmd("gtk-launch Gemini.desktop"), { description = "AI Gemini Chat" })
hl.bind("SUPER + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind("SUPER + Comma", hl.dsp.exec_cmd("dms ipc call settings focusOrToggle"), { description = "DMS Settings" })
hl.bind("SUPER + N", hl.dsp.exec_cmd("dms ipc call notifications dismiss"), { description = "Notifications: Dismiss" })
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"), {
  description =
  "Notifications: Toggle"
})
hl.bind("SUPER + ALT + N", hl.dsp.exec_cmd("dms ipc call notepad toggle"),
  { description = "Notepad: Toggle" })
hl.bind("SUPER + Y", hl.dsp.exec_cmd("dms ipc call wallpaperCarousel toggle"), { description = "Wallpaper Carousel" })
hl.bind("SUPER + CTRL + Y", hl.dsp.exec_cmd("dms ipc call dash toggle wallpaper"),
  { description = "Dashboard: Wallpaper" })
hl.bind("SUPER + TAB", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("dms ipc call dash toggle overview"), { description = "Dashboard: Overview" })
hl.bind("SUPER + W", hl.dsp.exec_cmd("dms ipc call dash toggle weather"), { description = "Dashboard: Weather" })
hl.bind("SUPER + M", hl.dsp.exec_cmd("dms ipc call dash toggle media"), { description = "Dashboard: Media" })
hl.bind("SUPER + Minus", hl.dsp.exec_cmd("dms ipc call powermenu toggle"), { description = "Power Menu: Toggle" })
hl.bind("SUPER + E", hl.dsp.exec_cmd("dms ipc call defaultApp fileManager"), { description = "File Manager" })

-- === Cheat sheet
hl.bind("SUPER + SHIFT + Slash", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"),
  { description = "Keybinds Cheatsheet: Toggle" })

-- === Security ===
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"), { description = "Lock Screen" })
hl.bind("ALT + CTRL + BackSpace", hl.dsp.exit(), { description = "Exit" })
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle"))

-- === Audio Controls ===
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 5"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { locked = true })
hl.bind("CTRL + XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call mpris increment 5"),
  { locked = true, repeating = true })
hl.bind("CTRL + XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call mpris decrement 5"),
  { locked = true, repeating = true })

-- === Brightness Controls ===
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[dms ipc call brightness increment 5 ""]]),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[dms ipc call brightness decrement 5 ""]]),
  { locked = true, repeating = true })

-- === Window Management ===
hl.bind("SUPER + C", hl.dsp.window.close(), { description = "Close window" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
-- client=fullscreen tells the app (e.g. browser video) to fill its window; internal=none
-- leaves Hyprland's tiled geometry untouched, so the tile doesn't resize.
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }))
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }), { description = "Float/unfloat window" })
hl.bind("SUPER + G", hl.dsp.group.toggle(), { description = "Group: Toggle" })
hl.bind("SUPER + CTRL + W", hl.dsp.exec_cmd("dms ipc call window-rules toggle"), { description = "Create window rule" })

-- === Focus Navigation ===
hl.bind("SUPER + H", hl.dsp.layout("focus l"))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + L", hl.dsp.layout("focus r"))

-- === Window Movement ===
hl.bind("SUPER + SHIFT + H", hl.dsp.layout("swapcol l"))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.layout("swapcol r"))

-- === Column Navigation ===
hl.bind("SUPER + Home", hl.dsp.focus({ window = "first" }))
hl.bind("SUPER + End", hl.dsp.focus({ window = "last" }))

-- === Output Navigation ===
hl.bind("SUPER + CTRL + H", hl.dsp.focus({ monitor = "l" }))
hl.bind("SUPER + CTRL + J", hl.dsp.focus({ monitor = "d" }))
hl.bind("SUPER + CTRL + K", hl.dsp.focus({ monitor = "u" }))
hl.bind("SUPER + CTRL + L", hl.dsp.focus({ monitor = "r" }))

-- === Move to Monitor ===
hl.bind("SUPER + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }))
hl.bind("SUPER + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "d" }))
hl.bind("SUPER + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "u" }))
hl.bind("SUPER + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }))

-- === Workspace Navigation ===
hl.bind("SUPER + U", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + I", hl.dsp.focus({ workspace = "r-1" }))

-- === Workspace Management ===
hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd("dms ipc call workspace-rename open"))

-- === Move Workspaces ===
hl.bind("SUPER + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("SUPER + SHIFT + U", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + I", hl.dsp.window.move({ workspace = "e-1" }))

-- === Mouse Wheel Navigation ===
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

-- === Touchpad Gestures ===
hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })
hl.gesture({
  fingers = 3,
  direction = "left",
  action = function()
    hl.dispatch(hl.dsp.focus({ direction = "l" }))
  end
})
hl.gesture({
  fingers = 3,
  direction = "right",
  action = function()
    hl.dispatch(hl.dsp.focus({ direction = "r" }))
  end
})
hl.gesture({
  fingers = 4,
  direction = "vertical",
  action = function()
    hl.exec_cmd("dms ipc call hypr toggleOverview")
  end
})

-- === Numbered Workspaces ===
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" }))

-- === Move to Numbered Workspaces ===
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))

-- === Column Management ===
hl.bind("SUPER + bracketleft", hl.dsp.layout("preselect l"))
hl.bind("SUPER + bracketright", hl.dsp.layout("preselect r"))

-- === Sizing & Layout ===
hl.bind("SUPER + R", hl.dsp.layout("colresize +conf"))

-- === Move/resize windows with mainMod + LMB/RMB and dragging ===
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

hl.bind("SUPER + code:20", hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
  { description = "Expand window left" })
hl.bind("SUPER + code:21", hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
  { description = "Shrink window left" })

-- === Manual Sizing ===
-- hl.bind("SUPER + minus", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + equal", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })

-- === Screenshots ===
hl.bind("Print", hl.dsp.exec_cmd("dms screenshot"), { description = "Screenshot: Region" })
hl.bind("ALT + Print", hl.dsp.exec_cmd("dms screenshot scroll"), { description = "Screenshot: Scroll" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("dms screenshot window"), { description = "Screenshot: Focused Window" })
hl.bind("SUPER + Print", hl.dsp.exec_cmd("dms screenshot full"), { description = "Screenshot: Focused Output" })
hl.bind("SUPER + ALT + Print", hl.dsp.exec_cmd("dms screenshot all"), { description = "Screenshot: All Outputs" })

-- === Display Profiles ===
hl.bind("SUPER + P", hl.dsp.exec_cmd("dms ipc outputs cycleProfile"))

-- === System Controls ===
hl.bind("SUPER + SHIFT + P", hl.dsp.dpms({ action = "toggle" }))
