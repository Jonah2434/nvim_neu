return {
  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 6 -- Höhe auf 4 Zeilen für horizontales Terminal
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4 -- Beibehalten für vertikales Terminal
        else
          return 20 -- Standardgröße für schwebendes Terminal
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Zusätzliche Keymaps für Terminal
      local map = vim.keymap.set
      local term_opts = { silent = true }

      -- Escape im Terminal
      map("t", "<esc>", [[<C-\><C-n>]], term_opts)
      map("t", "<C-h>", [[<C-\><C-n><C-W>h]], term_opts)
      map("t", "<C-j>", [[<C-\><C-n><C-W>j]], term_opts)
      map("t", "<C-k>", [[<C-\><C-n><C-W>k]], term_opts)
      map("t", "<C-l>", [[<C-\><C-n><C-W>l]], term_opts)
    end,
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=40<CR>", desc = "Vertical Terminal" },
    },
  },
}
