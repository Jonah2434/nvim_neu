local M = {}

-- Liste der Themes und ihrer Stile
M.themes = {
  ["catppuccin"] = { "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" },
  ["tokyonight"] = { "tokyonight-day", "tokyonight-storm", "tokyonight-night", "tokyonight-moon" },
  ["nightfox"] = { "dawnfox", "dayfox", "nightfox", "nordfox", "carbonfox", "terafox" },
  ["kanagawa"] = { "kanagawa-lotus", "kanagawa-dragon", "kanagawa-wave" },
  ["rose-pine"] = { "rose-pine-dawn", "rose-pine-main", "rose-pine-moon" },
  ["gruvbox-material"] = { "gruvbox-material-soft", "gruvbox-material-medium", "gruvbox-material-hard" },
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
  M.themes = opts.themes or M.themes
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
