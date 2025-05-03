return {
  -- LSP Manager
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "windwp/nvim-autopairs",
      "folke/neodev.nvim",
    },
    config = function()
      -- Neodev für Neovim Lua API (optional, kann entfernt werden, wenn nicht benötigt)
      require("neodev").setup()

      local lspconfig = require("lspconfig")

      -- Nur HTML und CSS LSP aktivieren
      local servers = {
        "html",   -- HTML
        "cssls",  -- CSS
      }

      -- Setup Mason LSP
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      -- Setup nvim-cmp
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Autopairs für automatische Klammern
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local npairs = require('nvim-autopairs')

      npairs.setup({
        check_ts = true,
        disable_filetype = { "TelescopePrompt", "vim" },
      })

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      -- Nur für HTML und CSS aktivieren
      local enabled_filetypes = {
        html = true,
        css = true,
      }

      -- Deaktivierte Dateitypen explizit auflisten
      local disabled_filetypes = {
        text = true,
        markdown = true,
        bash = true,
        java = true,
        -- Weitere Dateitypen hier hinzufügen, falls nötig
      }

      cmp.setup({
        enabled = function()
          local filetype = vim.bo.filetype
          -- Deaktiviere cmp für nicht erwünschte Dateitypen
          if disabled_filetypes[filetype] then
            return false
          end
          -- Aktiviere cmp nur für HTML und CSS
          return enabled_filetypes[filetype] or false
        end,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Setup LSP completion capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- On attach function für LSP
      local on_attach = function(client, bufnr)
        -- Nur für HTML und CSS Keybindings aktivieren
        local filetype = vim.bo[bufnr].filetype
        if enabled_filetypes[filetype] then
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
          -- Die print-Anweisung wurde entfernt
        end
      end

      -- Initialize each server with proper configuration
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- Diagnostics configuration
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },

  -- LSP Tools
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  },

  -- Auto pairs für automatische Klammern
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}
