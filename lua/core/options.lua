-- Allgemeine Neovim-Optionen
vim.opt.number = true         -- Zeige Zeilennummern
vim.opt.relativenumber = false -- Relative Zeilennummern
vim.opt.numberwidth = 4        -- Breite der Ziffernleiste (Standard ist 4)
vim.opt.signcolumn = "number"  -- Signcolumn mit Zeilennummern kombinieren
vim.opt.mouse = "a"             -- Mausunterstützung
vim.opt.showmode = false         -- Modus nicht in der Statuszeile anzeigen
vim.opt.clipboard = "unnamedplus" -- System-Clipboard verwenden
vim.opt.breakindent = true       -- Einrückung bei Zeilenumbruch
vim.opt.undofile = true          -- Persistente Undo-History
vim.opt.ignorecase = true        -- Groß-/Kleinschreibung bei Suche ignorieren
vim.opt.smartcase = true         -- Smart Case bei Suche
vim.opt.updatetime = 250          -- Schnelleres Update (für Diagnosen)
vim.opt.timeoutlen = 300          -- Zeit für Keymap-Sequenzen
vim.opt.splitright = true         -- Neue Splits rechts öffnen
vim.opt.splitbelow = true         -- Neue Splits unten öffnen
vim.opt.list = true               -- Versteckte Zeichen anzeigen
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Zeichen für Tabs, etc.
vim.opt.inccommand = "split"      -- Live-Vorschau für Substitute
vim.opt.cursorline = true         -- Aktuelle Zeile hervorheben
vim.opt.scrolloff = 10            -- Mindestabstand zum Rand beim Scrollen
vim.opt.termguicolors = true      -- True Color Support

-- Einrückungseinstellungen
vim.opt.autoindent = true         -- Übernimmt Einrückung der vorherigen Zeile
vim.opt.smartindent = false        -- Deaktiviert, da Treesitter die Einrückung übernimmt
vim.opt.expandtab = true           -- Tabs in Spaces umwandeln
vim.opt.tabstop = 2                -- 2 Spaces pro Tab
vim.opt.shiftwidth = 2             -- 2 Spaces für automatische Einrückung
