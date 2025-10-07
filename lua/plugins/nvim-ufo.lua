return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		-- Basic fold settings
		vim.o.foldcolumn = "1" -- show fold column
		vim.o.foldlevel = 99 -- keep folds open by default
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		-- Setup UFO
		require("ufo").setup({
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,
		})
		-- Keymaps for JetBrains-like folding
		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
		vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
	end,
}
