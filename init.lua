-- Init.lua
require("core.options")
require("core.keymaps")
require("core.lazy")

-- Theme-Switcher initialisieren
require("theme-switcher").setup({
  default_theme = "catppuccin",
  default_style = "catppuccin-mocha",
  light_theme = "catppuccin",
  light_style = "catppuccin-latte",
  themes = {
    ["catppuccin"] = { "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" },
    ["tokyonight"] = { "tokyonight-day", "tokyonight-storm", "tokyonight-night", "tokyonight-moon" },
    ["nightfox"] = { "dawnfox", "dayfox", "nightfox", "nordfox", "carbonfox", "terafox" },
    ["kanagawa"] = { "kanagawa-lotus", "kanagawa-dragon", "kanagawa-wave" },
    ["rose-pine"] = { "rose-pine-dawn", "rose-pine", "rose-pine-moon" },
    ["gruvbox-material"] = { "gruvbox-material", "gruvbox-material", "gruvbox-material" },
    
    -- Neue Themes hier eingefügt
    ["dracula"] = { "dracula" },
    ["nord"] = { "nord" },
    ["onedark"] = { "onedark", "onedark-dark", "onedark-darker", "onedark-cool", "onedark-deep", "onedark-warm", "onedark-warmer" },
    ["material"] = { "material", "material-oceanic", "material-deep-ocean", "material-palenight", "material-lighter", "material-darker" },
    ["everforest"] = { "everforest", "everforest-soft", "everforest-medium", "everforest-hard" },
    ["solarized"] = { "solarized", "solarized-light", "solarized-dark" },
    ["monokai-pro"] = { "monokai-pro", "monokai-pro-classic", "monokai-pro-octagon", "monokai-pro-pro", "monokai-pro-machine", "monokai-pro-ristretto", "monokai-pro-spectrum" },
  }
})
