return {
	"xiyaowong/transparent.nvim",
	dependencies = {
		"savq/melange-nvim",
		"folke/tokyonight.nvim",
		"catppuccin/nvim",
		"rebelot/kanagawa.nvim",
		"rose-pine/neovim",
		"edeneast/nightfox.nvim",
		"navarasu/onedark.nvim",
		"projekt0n/github-nvim-theme",
		"sainnhe/everforest",
		"mofiqul/vscode.nvim",
		"scottmckendry/cyberdream.nvim",
		"olimorris/onedarkpro.nvim",
		"mofiqul/dracula.nvim",
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme melange")
			-- vim.cmd("colorscheme tokyonight-night")
			-- vim.cmd("colorscheme catppuccin-mocha")
			-- vim.cmd("colorscheme kanagawa-dragon")
			-- vim.cmd("colorscheme rose-pine")
			-- vim.cmd("colorscheme nightfox")
			-- vim.cmd("colorscheme onedark")
			-- vim.cmd("colorscheme github_dark")
			-- vim.cmd("colorscheme everforest")
			-- vim.cmd("colorscheme vscode")
			-- vim.cmd("colorscheme cyberdream")
			-- vim.cmd("colorscheme onedarkpro")
			-- vim.dmd("colorscheme dracula")
			-- vim.cmd("colorscheme material")
		end,
	},
	config = function()
		vim.cmd("colorscheme carbonfox")
		require("transparent").setup({
			groups = {
				"Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
				"Statement", "PreProc", "Type", "Underlined", "Todo", "String",
				"Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
				"SignColumn", "CursorLine", "CursorLineNr", "StatusLine", "StatusLineNC",
				"EndOfBuffer", "GitSignsAdd", "GitSignsChange", "GitSignsDelete",
			},
			extra_groups = {
				"NormalFloat",
				"FloatBorder",
				"NvimTreeNormal"
			},
			exclude_groups = {},
		})
	end,
}
