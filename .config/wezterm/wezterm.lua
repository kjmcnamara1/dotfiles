-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

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
    family = "Victor Mono",
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

-- config.font_rules = {
--   {
--     intensity = "Bold",
--     italic = true,
--     font = wezterm.font {
--       family = "Fira Code Script",
--       weight = "Bold",
--       style = "Italic",
--     },
--   },
--   {
--     italic = true,
--     intensity = "Half",
--     font = wezterm.font {
--       family = "Fira Code Script",
--       weight = "DemiBold",
--       style = "Italic",
--     },
--   },
--   {
--     italic = true,
--     intensity = "Normal",
--     font = wezterm.font_with_fallback({
--       {
--         family = "Fira Code Script",
--         style = "Italic",
--       },
--       {
--         family = "Fira Code",
--         style = "Italic",
--       },
--     }),
--   },
-- }


config.font_rules = {
  {
    italic = true,
    intensity = "Bold",
    font = wezterm.font({
      family = "Victor Mono",
      weight = "Bold",
      style = "Italic",
    }),
  },
  {
    italic = true,
    intensity = "Half",
    font = wezterm.font({
      family = "Victor Mono",
      weight = "Thin",
      style = "Italic",
    }),
  },
  {
    italic = true,
    intensity = "Normal",
    font = wezterm.font({
      family = "Victor Mono",
      weight = "Regular",
      style = "Italic",
    }),
  },
  {
    italic = false,
    intensity = "Bold",
    font = wezterm.font({
      family = "Victor Mono",
      weight = "Bold",
    }),
  },
  {
    italic = false,
    intensity = "Half",
    font = wezterm.font({
      family = "Victor Mono",
      weight = "Light",
    }),
  },
}


config.window_background_opacity = 0.75
config.win32_system_backdrop = "Acrylic"

-- and finally, return the configuration to wezterm
return config
---------------------------------
-- ==============================
-- 0123456789
-- ! @ # $ % ^ & * ( ) - _ = + ` ~ [ ] { } ; : ' " , . < > / ?
-- -<< -< -<- <-- <--- <<- <- -> ->> --> ---> ->- >- >>-
-- =<< =< =<= <== <=== <<= <= => =>> ==> ===> =>= >= >>=
-- <-> <--> <---> <----> <=> <==> <===> <====> :: ::: __
-- <~~ </ </> /> ~~> == != /= ~= <> === !== !=== =/= =!=
-- <: := *= *+ <* <*> *> <| <|> |> <. <.> .> +* =* =: :>
-- (* *) /* */ [| |] {| |} ++ +++ \/ /\ |- -| <!-- <!---
-- 1/2 3/4 2/3
-- |
-- |
