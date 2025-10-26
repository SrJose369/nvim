-- ================================================================================================
-- TITLE : ccc.nvim
-- LINKS :
--   > github : https://github.com/uga-rosa/ccc.nvim
-- ABOUT : colour picker & highlighter for neovim
-- ================================================================================================

return {
	"uga-rosa/ccc.nvim",
	keys = {
		{mode="n", "<leader>op", ":CccPick<CR>", silent = true, desc = "Open color picker" },
		{mode="n", "<leader>oc", ":CccConvert<CR>", silent = true, desc = "Open color convert" },
		{mode="n", "<leader>oh", ":CccHighlighterToggle<CR>", silent = true, desc = "Toggle line highlight" },
	},
	config = function()
		require("ccc").setup({
			highlighter = {
				auto_enable = false, -- enable highlight automatically
				lsp = true -- highlight colors from LSP too
			},
			highlight_mode = "virtual", -- small circles with colour next to the declaration
		})
	end,
}
