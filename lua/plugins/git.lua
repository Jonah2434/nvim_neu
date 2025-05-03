return {
  -- Git-Integrationstools
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
    event = "VeryLazy",
  },
  
  -- Lazygit Integration (Terminal GUI für Git)
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = " LazyGit" },
    },
    opts = {
      floating_window_winblend = 0, -- Transparenz (0 = undurchsichtig, 100 = transparent)
      floating_window_scaling_factor = 0.9, -- Skalierungsfaktor für das Floating Window
      floating_window_corner_chars = { "╭", "╮", "╰", "╯" }, -- Elegante Ecken
      lazygit_floating_window_winblend = 0, -- Transparenz des LazyGit Fensters
      lazygit_floating_window_scaling_factor = 0.9, -- Skalierungsfaktor
      lazygit_floating_window_use_plenary = true, -- Verwende plenary für das Fenster
    },
  },
  
  -- Git Differenz am Rand
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      current_line_blame = false, -- Toggle mit <leader>tb
      sign_priority = 6,
      update_debounce = 200,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = " Next Hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = " Prev Hunk" })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = " Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = " Reset Hunk" })
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = " Stage Selected" })
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = " Reset Selected" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = " Stage Buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = " Undo Stage" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = " Reset Buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = " Preview Hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = " Blame Line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = " Toggle Blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = " Diff This" })
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, { desc = " Diff This ~" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = " Toggle Deleted" })
      end,
    },
  },
  
  -- Git Commit-Nachrichten-Unterstützung
  {
    "rhysd/committia.vim",
    event = "BufReadPre COMMIT_EDITMSG",
  },
  
  -- Git-Konflikte auflösen
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<CR>", desc = " DiffView Open" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<CR>", desc = " DiffView History" },
      { "<leader>gdc", "<cmd>DiffviewClose<CR>", desc = " DiffView Close" },
    },
    opts = {
      icons = {
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
        },
        file_history = {
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              max_count = 512,
              follow = true,
            },
            multi_file = {
              max_count = 128,
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
        },
      },
      commit_log_panel = {
        win_config = {},
      },
      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
    },
  },
}
