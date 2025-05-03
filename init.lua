-- Init.lua
require("core.options")
require("core.keymaps")
require("core.lazy")

-- Theme-Switcher initialisieren
require("theme-switcher").setup({
  default_theme = "catppuccin",
  default_style = "mocha",
  light_theme = "catppuccin",
  light_style = "latte",
  themes = {
    ["catppuccin"] = { "latte", "frappe", "macchiato", "mocha" },
    ["tokyonight"] = { "day", "storm", "night", "moon" },
    ["nightfox"] = { "dawnfox", "dayfox", "nightfox", "nordfox", "carbonfox", "terafox" },
    ["kanagawa"] = { "lotus", "dragon", "wave" },
    ["rose-pine"] = { "dawn", "main", "moon" },
    ["gruvbox-material"] = { "soft", "medium", "hard" },
  }
})
