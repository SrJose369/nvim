return {
	"xiyaowong/transparent.nvim",
	dependencies = {
		"savq/melange-nvim",
		-- "folke/tokyonight.nvim",
		lazy = false,
		-- priority = 1000,
		config = function()
			-- vim.cmd("colorscheme melange")
			-- vim.cmd("colorscheme tokyonight-night")
			-- colorscheme tokyonight-night
			-- colorscheme tokyonight-storm
			-- colorscheme tokyonight-day
			-- colorscheme tokyonight-moon
		end,
	},
	config = function()
		require("transparent").setup({
			groups = {
				"Normal",
				"CursorLine"
				-- "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
				-- "Statement", "PreProc", "Type", "Underlined", "Todo", "String",
				-- "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
				-- "SignColumn", "CursorLine", "CursorLineNr", "StatusLine", "StatusLineNC",
				-- "EndOfBuffer",
			},
			extra_groups = {
				"NormalFloat"
				-- -- Floats
				-- "NormalFloat", "FloatBorder",
				-- -- Completion (core + nvim-cmp)
				-- "Pmenu", "PmenuSel", "PmenuBorder", "DocBorder",
				-- -- Which-key (optional, if you want plugin-managed transparency)
				-- "WhichKey", "WhichKeyBorder", "WhichKeyFloat", "WhichKeyValue",
			},
			exclude_groups = {},
		})
		-- Ensure clearing happens after colorscheme applies
		-- vim.cmd([[colorscheme tokyonight-night]])
		vim.cmd([[colorscheme melange]])
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				-- vim.cmd("TransparentEnable")
			end,
		})
	end,
}
