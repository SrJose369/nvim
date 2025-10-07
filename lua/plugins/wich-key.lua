-- ================================================================================================
-- TITLE : which-key
-- ABOUT : WhichKey helps you remember your Neovim keymaps, by showing keybindings as you type.
-- LINKS :
--   > github : https://github.com/folke/which-key.nvim
-- ================================================================================================

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function()
		require("which-key").setup({
			win = {
				wo = { windowblend = 0 },
			},
		})
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
		-- vim.api.nvim_set_hl(0, "WhichKey",       { bg = "NONE" })
		-- vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = "NONE" })
		-- vim.api.nvim_set_hl(0, "WhichKeyFloat",  { bg = "NONE" })
		-- vim.api.nvim_set_hl(0, "WhichKeyValue",  { bg = "NONE" })
	end,
}
