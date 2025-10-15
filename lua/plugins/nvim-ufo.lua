return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.o.foldcolumn = "0" -- show fold column
		vim.o.foldlevel = 99 -- keep folds open by default
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		local ufo = require("ufo")
		ufo.setup({
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,
		})
		-- Keymaps for JetBrains-like folding
		vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
		vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds except kinds" })
		vim.keymap.set("n", "zm", ufo.closeFoldsWith, { desc = "Close folds with" })
	end,
}
