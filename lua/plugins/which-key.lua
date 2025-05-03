-- Datei: nvim_neu/lua/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = { -- opts Block beginnt hier
		plugins = { spelling = true },
		delay = 200,
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		win = { -- opts.win Block
			border = "rounded",
			-- position = "bottom", -- <<< ENTFERNT
			-- margin = { 1, 0, 1, 0 }, -- <<< ENTFERNT
			-- padding = { 1, 2, 1, 2 }, -- <<< ENTFERNT (vorsorglich)
		}, -- opts.win Block endet hier
		layout = {
			height = { min = 4, max = 25 },
			width = { min = 20, max = 50 },
			spacing = 3,
			align = "left",
		},
	}, -- opts Block endet hier
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			mode = { "n", "v" },
			{ "<leader>", group = "Leader" },
			{ "<leader>b", group = " Buffer" },
			{ "<leader>c", group = " Code" },
			{ "<leader>f", group = " Find/File" },
			{ "<leader>g", group = " Git" },
			{ "<leader>h", group = " Hunk" },
			{ "<leader>l", group = " LSP" },
			{ "<leader>t", group = " Terminal/Toggle" },
			{ "<leader>x", group = " Diagnostics" },
			{ "g", group = " Go" },
		})
	end,
}
