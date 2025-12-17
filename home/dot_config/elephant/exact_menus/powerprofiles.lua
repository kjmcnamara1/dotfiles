Name        = "powerprofiles"
NamePretty  = "Power Profiles"
Description = "Power profiles daemon"
-- Icon          = "bookmark"
Cache       = true
Terminal    = true
-- Action      = "powerprofilesctl set %VALUE%"
Action      = "notify-send %VALUE%"

function GetEntries()
  local entries = {}

  local handle = io.popen(
    [[powerprofilesctl list | awk '/^\s*[* ]\s*[a-zA-Z0-9\-]+:$/ { gsub(/^[*[:space:\]\]+|:$/,""); print }' | tac]])
  if handle then
    for line in handle:lines() do
      -- local filename = line:match("([^/]+)$")
      table.insert(entries, {
        Text = line,
        Subtext = "power profile",
        Value = line,
        -- Actions = {
        --   up = "notify-send up",
        --   down = "notify-send down",
        -- },
        -- Preview = line,
        -- PreviewType = "file",
        -- Icon = line
      })
    end
    handle:close()
  end

  return entries
end
