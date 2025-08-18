require("starship"):setup({ config_file = "~/.config/starship/starship_yazi.toml" })

require("full-border"):setup()

require("git"):setup()

-- if os.getenv("NVIM") then
--   require("toggle-pane"):entry("min-preview")
-- end
