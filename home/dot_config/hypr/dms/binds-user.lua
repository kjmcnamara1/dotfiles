-- DMS user keybind overrides (edit via Control Center or dms; do not remove this header)

-- Monitor-relative workspace numbering. HL_MONITOR_WS_BASE (dms/workspaces.lua)
-- maps each output to its private block of 9 workspace IDs; these binds
-- resolve "workspace N" against whichever monitor is currently focused, so
-- SUPER+1 always means "this screen's 1st workspace" regardless of monitor.
local function active_base()
  local mon = hl.get_active_monitor()
  return (mon and HL_MONITOR_WS_BASE[mon.name]) or 0
end

for n = 1, 9 do
  hl.unbind("SUPER + " .. n)
  hl.bind("SUPER + " .. n, function()
    hl.dispatch(hl.dsp.focus({ workspace = tostring(active_base() + n) }))
  end)

  hl.unbind("SUPER + SHIFT + " .. n)
  hl.bind("SUPER + SHIFT + " .. n, function()
    hl.dispatch(hl.dsp.window.move({ workspace = tostring(active_base() + n) }))
  end)
end

-- SUPER+U/I: focus the next/previous workspace within the focused monitor's
-- own block of 9, wrapping around at the ends.
local function focus_relative_workspace(delta)
  local mon = hl.get_active_monitor()
  local base = (mon and HL_MONITOR_WS_BASE[mon.name]) or 0
  local ws = hl.get_active_workspace(mon)
  local local_id = ws and (ws.id - base) or 1
  local next_local = ((local_id - 1 + delta) % 9) + 1
  hl.dispatch(hl.dsp.focus({ workspace = tostring(base + next_local) }))
end

hl.unbind("SUPER + U")
hl.bind("SUPER + U", function() focus_relative_workspace(1) end)

hl.unbind("SUPER + I")
hl.bind("SUPER + I", function() focus_relative_workspace(-1) end)
