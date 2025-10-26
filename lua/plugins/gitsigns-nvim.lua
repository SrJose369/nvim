-- ================================================================================================
-- TITLE : gitsigns.nvim
-- LINKS :
--   > github : https://github.com/lewis6991/gitsigns.nvim
-- ABOUT : deep buffer integration for git.
-- ================================================================================================

return {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	config = function()
		require("gitsigns").setup({
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				vim.keymap.set("n", "<leader>hn", function()
					if vim.wo.diff then
						vim.cmd.normal({"]c", bang = true})
					else
						gitsigns.nav_hunk("next")
					end
				end)
				vim.keymap.set("n", "<leader>hp", function()
					if vim.wo.diff then
						vim.cmd.normal({"[c", bang = true})
					else
						gitsigns.nav_hunk("prev")
					end
				end)
				-- Actions
				vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Git Hunk" })
				vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Git Hunk" })
				vim.keymap.set("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Git Hunk" })
				vim.keymap.set("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Git Hunk" })
				vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Git Buffer" })
				vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Git Buffer" })
				vim.keymap.set("n", "<leader>hP", gitsigns.preview_hunk, { desc = "Preview Git Hunk" })
				vim.keymap.set("n", "<leader>hI", gitsigns.preview_hunk_inline, { desc = "Preview Git Hunk Inline" })
				vim.keymap.set("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Git Line" })
				vim.keymap.set("n", "<leader>ha", gitsigns.diffthis, { desc = "Diff This" })
				vim.keymap.set("n", "<leader>hd", function() gitsigns.diffthis("~") end, { desc = "Diff This ~" })
				vim.keymap.set("n", "<leader>hQ", function() gitsigns.setqflist("all") end, { desc = "All Hunks list" })
				vim.keymap.set("n", "<leader>hq", gitsigns.setqflist, { desc = "Buffer Hunk list" })
				-- Toggles
				vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toogle Git Blame" })
				vim.keymap.set("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toogle Git Word Diff" })
				-- Text object
				vim.keymap.set({"o", "x"}, "ih", gitsigns.select_hunk, { desc = "Select Hunk text-object" })
			end,
		})
		vim.opt.foldcolumn = "0"
	end,
}
