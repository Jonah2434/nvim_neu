-- Datei: nvim_neu/lua/plugins/editor.lua
return {
  -- Mini-Plugins
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "gza",
          delete = "gzD",
          find = "gzF",
          find_left = "gzL",
          highlight = "gzH",
          replace = "gzR",
          update_n_lines = "gzN",
        },
      })
      require("mini.pairs").setup({})
    end,
  },

  -- Bessere Schriftauswahl
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input:",
        prompt_align = "left",
        insert_only = true,
        border = "rounded",
        relative = "cursor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          winblend = 0,
          wrap = false,
        },
        mappings = {
          n = {
            ["<Esc>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          i = {
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
            ["<Up>"] = "HistoryPrev",
            ["<Down>"] = "HistoryNext",
          },
        },
        override = function(conf)
          return conf
        end,
        get_config = nil,
      },
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        telescope = nil,
        fzf = {
          window = { width = 0.5, height = 0.4 },
        },
        fzf_lua = {
          winopts = { width = 0.5, height = 0.4 },
        },
        nui = {
          position = "50%",
          size = nil,
          relative = "editor",
          border = { style = "rounded" },
          buf_options = { swapfile = false, filetype = "DressingSelect" },
          win_options = { winblend = 0 },
          max_width = 80,
          max_height = 40,
          min_width = 40,
          min_height = 10,
        },
        builtin = {
          border = "rounded",
          relative = "editor",
          buf_options = {},
          win_options = { winblend = 0 },
          width = nil,
          max_width = { 140, 0.8 },
          min_width = { 40, 0.2 },
          height = nil,
          max_height = 0.9,
          min_height = { 10, 0.2 },
          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
          override = function(conf)
            return conf
          end,
        },
        format_item_override = {},
        get_config = nil,
      },
    },
  },

  -- Besser UI (Nachrichten in Cmdline, Verlauf verfügbar)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        -- LSP-bezogene Einstellungen bleiben gleich
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        -- Presets bleiben gleich
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      messages = {
        enabled = true,
        view = "notify", -- Geändert von "cmdline" zu "notify" für Pop-up-Nachrichten
        view_error = "notify", -- Geändert von "cmdline" zu "notify"
        view_warn = "notify", -- Geändert von "cmdline" zu "notify"
        view_history = "messages", -- Verlaufsnachrichten in einem separaten Fenster anzeigen
        view_search = "virtualtext", -- Suchnachrichten als virtuellen Text anzeigen
      },
      notify = {
        -- Konfiguration für Benachrichtigungen
        enabled = true,
        view = "notify", -- Verwende die Notify-Ansicht
        level = 3, -- Info-Level und höher
        timeout = 3000, -- 3 Sekunden Anzeigedauer vor Ausblendung
        minimum_width = 10, -- Minimale Breite
      },
      -- Die history-Konfiguration bleibt bestehen, damit der Verlauf funktioniert
      history = {
        view = "split",
        opts = { border = "rounded", title = "Notifications" },
        filter = { any = { { event = "notify" }, { error = true }, { warning = true } } }, 
      },
      routes = {
        -- Nachrichten für kurze Zeit anzeigen und dann ausblenden
        {
          filter = { event = "msg_show", kind = "", level = "info" },
          opts = { timeout = 2500 }, -- 2,5 Sekunden für normale Informationen
        },
        {
          filter = { event = "msg_show", kind = "", level = "warning" },
          opts = { timeout = 3500 }, -- 3,5 Sekunden für Warnungen
        },
        {
          filter = { event = "msg_show", kind = "", level = "error" },
          opts = { timeout = 5000 }, -- 5 Sekunden für Fehler
        },
      },
    },
  },

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    cmd = "Telescope",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
      pickers = {
        colorscheme = {
          enable_preview = true, -- Aktiviere die Vorschau für Colorschemes
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
  },

  -- Bessere Tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "alpha",
            text = "",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Automatisch Bufferline ausblenden, wenn nur ein Buffer geöffnet ist
      vim.api.nvim_create_autocmd({ "BufEnter", "BufDelete", "BufWinEnter" }, {
        callback = function()
          local listed_buffers = vim.tbl_filter(function(bufnr)
            return vim.api.nvim_buf_get_option(bufnr, "buflisted")
              and vim.api.nvim_buf_get_option(bufnr, "buftype") ~= "nofile"
              and vim.api.nvim_buf_get_option(bufnr, "filetype") ~= "alpha"
          end, vim.api.nvim_list_bufs())
          if #listed_buffers <= 1 then
            vim.o.showtabline = 0 -- Bufferline ausblenden
          else
            vim.o.showtabline = 2 -- Bufferline anzeigen
          end
        end,
      })
    end,
  },

  -- Treesitter für bessere Syntax und Einrückung
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "html", "css" }, -- Passe dies an deine benötigten Sprachen an
        indent = {
          enable = true,
          disable = {},
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  -- HTML Formatter (Beispiel: Prettier)
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- Formatierung vor dem Speichern (optional)
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          html = { "prettier" }, -- Definiere hier Formatter pro Dateityp
          css = { "prettier" },
          lua = { "stylua" },
          -- javascript = { "prettier" },
          -- python = { "black" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true, -- Versuche LSP-Formatierung, wenn kein Konform-Formatter gefunden wird
        },
        -- Konfiguration für spezifische Formatter (optional)
        formatters = {
          prettier = {
            prepend_args = { "--tab-width", "2", "--single-quote", "false" },
          },
          stylua = {
             -- Konfiguration für Stylua
          },
        },
      })

      -- Keymap zum manuellen Formatieren
      vim.keymap.set({ "n", "v" }, "<leader>lf", function() -- Geändert von <leader>f zu <leader>lf
        require("conform").format({
          lsp_fallback = true,
          async = false, -- Oder true für asynchrone Formatierung
          timeout_ms = 500,
        })
      end, { desc = " Format file or range" }) -- Beschreibung angepasst
    end,
  },

} -- Ende der Datei
