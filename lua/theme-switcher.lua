local M = {}

-- Liste der Themes und ihrer Stile
M.themes = {
  ["catppuccin"] = { "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" },
  ["tokyonight"] = { "tokyonight-day", "tokyonight-storm", "tokyonight-night", "tokyonight-moon" },
  ["nightfox"] = { "dawnfox", "dayfox", "nightfox", "nordfox", "carbonfox", "terafox" },
  ["kanagawa"] = { "kanagawa-lotus", "kanagawa-dragon", "kanagawa-wave" },
  ["rose-pine"] = { "rose-pine-dawn", "rose-pine", "rose-pine-moon" },
  ["gruvbox-material"] = { "gruvbox-material", "gruvbox-material", "gruvbox-material" },
  
  -- NEUE THEMES HIER EINGEFÜGT
  ["dracula"] = { "dracula" },
  ["nord"] = { "nord" },
  ["onedark"] = { "onedark", "onedark-dark", "onedark-darker", "onedark-cool", "onedark-deep", "onedark-warm", "onedark-warmer" },
  ["material"] = { "material", "material-oceanic", "material-deep-ocean", "material-palenight", "material-lighter", "material-darker" },
  ["everforest"] = { "everforest", "everforest-soft", "everforest-medium", "everforest-hard" },
  ["solarized"] = { "solarized", "solarized-light", "solarized-dark" },
  ["monokai-pro"] = { "monokai-pro", "monokai-pro-classic", "monokai-pro-octagon", "monokai-pro-pro", "monokai-pro-machine", "monokai-pro-ristretto", "monokai-pro-spectrum" },
}

M.default_theme = "catppuccin"
M.default_style = "catppuccin-mocha"
M.light_theme = "catppuccin"
M.light_style = "catppuccin-latte"

function M.setup(opts)
  M.default_theme = opts.default_theme or M.default_theme
  M.default_style = opts.default_style or M.default_style
  M.light_theme = opts.light_theme or M.light_theme
  M.light_style = opts.light_style or M.light_style
  
  -- Ensure themes are properly formatted with correct prefixes
  if opts.themes then
    M.themes = opts.themes
  end
  
  -- Setup initial colorscheme
  vim.cmd("colorscheme " .. M.default_style)
end

function M.toggle_theme(is_light)
  local current_theme = vim.g.colors_name or M.default_style
  local theme, style

  if is_light then
    if current_theme == M.light_style then
      theme, style = M.default_theme, M.default_style
    else
      theme, style = M.light_theme, M.light_style
    end
  else
    local found_theme, found_style
    for t, styles in pairs(M.themes) do
      for _, s in ipairs(styles) do
        if current_theme == s then
          found_theme, found_style = t, s
          break
        end
      end
      if found_theme then break end
    end

    if found_theme and found_style then
      local styles = M.themes[found_theme]
      local next_style_idx = (vim.fn.index(styles, found_style) + 1) % #styles
      style = styles[next_style_idx + 1]
      theme = found_theme
    else
      theme, style = M.default_theme, M.default_style
    end
  end

  -- Debug info (can be removed later)
  print("Switching to theme: " .. style)
  
  -- Set the colorscheme
  vim.cmd("colorscheme " .. style)
end

-- Funktion für Telescope-Vorschau
function M.telescope_picker()
  local telescope = require("telescope.builtin")

  -- Erstelle eine flache Liste aller Themes
  local theme_list = {}
  for _, styles in pairs(M.themes) do
    for _, style in ipairs(styles) do
      table.insert(theme_list, style)
    end
  end

  -- Verwende den Standard-Colorscheme-Picker von Telescope
  telescope.colorscheme({
    prompt_title = "Theme Switcher (Preview)",
    enable_preview = true, -- Aktiviere die Vorschau explizit
    -- Filtere die Liste auf die definierten Themes
    results = theme_list,
  })
end

return M
