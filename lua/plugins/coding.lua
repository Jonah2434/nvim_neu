-- Datei: nvim_neu/lua/plugins/coding.lua
return {
  -- Auto Pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end,
  },

  -- Git Zeichen in der Gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = { interval = 1000, follow_files = true },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = { enable = false },
    },
  },

  -- Treesitter Kontext
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        trim_scope = "outer",
        patterns = {
          default = {
            "class",
            "function",
            "method",
          },
        },
        zindex = 20,
        mode = "cursor",
        separator = nil,
      })
    end,
  },

  -- Kommentare
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = { line = "gcc", block = "gbc" },
        opleader = { line = "gc", block = "gb" },
        extra = { above = "gcO", below = "gco", eol = "gcA" },
        mappings = { basic = true, extra = true, extended = false },
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },

  -- NEU: AI Plugin (ChatGPT.nvim mit lokalem Backend) - Konfiguration von dir übernommen
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim" -- Optional für UI-Verbesserungen
    },
    keys = {
      -- Beispiel-Mappings (siehe ChatGPT.nvim Doku für mehr)
      { "<leader>ca", "<cmd>ChatGPT<CR>", desc = "ChatGPT prompt window" },
      { "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>", mode = {"n", "v"}, desc = "Edit code with instruction" },
      { "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>", mode = {"n", "v"}, desc = "Correct grammar" },
      { "<leader>ct", "<cmd>ChatGPTRun translate<CR>", mode = {"n", "v"}, desc = "Translate" },
      -- ... weitere Mappings nach Bedarf
    },
    opts = {
      -- WICHTIG: Konfiguration für lokales Backend (z.B. Ollama)
      -- Du musst einen Ollama-Server (oder ein anderes kompatibles lokales Backend) laufen haben.
      api_host_cmd = "echo http://localhost:11434", -- Standard-Ollama-URL
      api_key_cmd = "echo ''", -- Kein API-Schlüssel für lokale Modelle nötig
      -- Wähle das Modell, das du in Ollama geladen hast (z.B. 'llama3', 'mistral', 'codellama')
      openai_params = {
        model = "llama3.2", -- Passe dies an dein verfügbares Modell an!
        -- Weitere Parameter nach Bedarf (temperature, max_tokens etc.)
        -- temperature = 0.7,
        -- max_tokens = 1000,
      },
       openai_edit_params = {
        model = "llama3.2", -- Modell für Bearbeitungsbefehle
        -- temperature = 0.7,
      },
      -- UI-Anpassungen
      popup_border = "rounded",
      popup_window = {
        border = "rounded",
        -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- Beispiel Highlighting
      },
      -- Weitere Optionen... (siehe :help chatgpt)
    },
    config = function(_, opts)
      require("chatgpt").setup(opts)
    end
  },

} -- Ende der Datei
