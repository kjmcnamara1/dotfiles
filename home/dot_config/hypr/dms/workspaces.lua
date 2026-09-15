-- Per-monitor workspace pools.
--
-- Each monitor owns a private block of 9 persistent workspace IDs so a
-- workspace can never drift onto another screen. binds-user.lua maps
-- SUPER+[1-9]/SUPER+U/SUPER+I onto these blocks relative to whichever
-- monitor is currently focused, so the numbers always mean "this screen's
-- Nth workspace" no matter which monitor you're on.
--
-- Keyed by the output name from dms/outputs.lua (physical port, top-left to
-- bottom-right in the 2x2 grid). Update this table if a monitor is swapped
-- to a different port.
HL_MONITOR_WS_BASE = {
  ["DP-3"] = 0,      -- top-left     -> workspaces 1-9
  ["HDMI-A-1"] = 10, -- top-right    -> workspaces 11-19
  ["DP-1"] = 20,     -- bottom-left  -> workspaces 21-29
  ["DP-2"] = 30,     -- bottom-right -> workspaces 31-39
}

for output, base in pairs(HL_MONITOR_WS_BASE) do
  for n = 1, 9 do
    hl.workspace_rule({
      workspace = tostring(base + n),
      monitor = output,
      persistent = true,
      default = (n == 1),
    })
  end
end
