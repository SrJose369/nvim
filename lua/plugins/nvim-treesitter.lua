-- ================================================================================================
-- TITLE : nvim-treesitter
-- ABOUT : Treesitter configurations and abstraction layer for Neovim.
-- LINKS :
--   > github : https://github.com/nvim-treesitter/nvim-treesitter
-- ================================================================================================

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	lazy = false,
	dependencies = {
		{
			"folke/ts-comments.nvim",
			event = "VeryLazy",
			opts = {},
			enabled = vim.fn.has("nvim-0.10.0") == 1,
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			lazy = true,
		}
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["al"] = "@class.outer",
						["il"] = "@class.inner",
						["ap"] = "@parameter.outer",
						["ip"] = "@parameter.inner",
					},
				},
			},
			ensure_installed = { -- language parsers that MUST be installed
				"bash",
				"c",
				"cpp",
				"css",
				"dockerfile",
				"go",
				"html",
				"java",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				-- "python",
				"rust",
				-- "svelte",
				"typescript",
				-- "vue",
				"yaml",
			},
			auto_install = false, -- auto-install any other parsers on opening new language files
			sync_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = "<TAB>",
				},
			},
		})
	end,
}
