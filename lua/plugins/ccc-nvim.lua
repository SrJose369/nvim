-- ================================================================================================
-- TITLE : ccc.nvim
-- LINKS :
--   > github : https://github.com/uga-rosa/ccc.nvim
-- ABOUT : colour picker & highlighter for neovim
-- ================================================================================================

return {
	"uga-rosa/ccc.nvim",
	config = function()
		local ccc = require("ccc")
		ccc.setup({
			highlighter = {
				auto_enable = false, -- enable highlight automatically
				lsp = true -- highlight colors from LSP too
			},
			highlight_mode = "virtual", -- small circles with colour next to the declaration
		})
		vim.keymap.set("n", "<leader>op", ":CccPick<CR>", { silent = true, desc = "Open color picker" })
		vim.keymap.set("n", "<leader>oc", ":CccConvert<CR>", { silent = true, desc = "Open color convert" })
		vim.keymap.set("n", "<leader>oh", ":CccHighlighterToggle<CR>", { silent = true, desc = "Toggle line highlight" })
	end,

}
