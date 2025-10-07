-- ================================================================================================
-- TITLE : gitsigns.nvim
-- LINKS :
--   > github : https://github.com/lewis6991/gitsigns.nvim
-- ABOUT : deep buffer integration for git.
-- ================================================================================================

return {
	"lewis6991/gitsigns.nvim",
	opts = {},
	config = function()
		require("gitsigns").setup({
			signcolunn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
		})
		vim.opt.foldcolumn = "0"
	end,
}
