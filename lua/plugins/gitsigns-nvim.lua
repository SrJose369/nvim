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
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end
				-- Navigation
				map("n", "<leader>hn", function()
					if vim.wo.diff then
						vim.cmd.normal({"]c", bang = true})
					else
						gitsigns.nav_hunk("next")
					end
				end)
				map("n", "<leader>hp", function()
					if vim.wo.diff then
						vim.cmd.normal({"[c", bang = true})
					else
						gitsigns.nav_hunk("prev")
					end
				end)
				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk)
				map("n", "<leader>hr", gitsigns.reset_hunk)
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>hS", gitsigns.stage_buffer)
				map("n", "<leader>hR", gitsigns.reset_buffer)
				map("n", "<leader>hP", gitsigns.preview_hunk)
				map("n", "<leader>hi", gitsigns.preview_hunk_inline)
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end)
				map("n", "<leader>ha", gitsigns.diffthis)
				map("n", "<leader>hd", function()
					gitsigns.diffthis("~")
				end)
				map("n", "<leader>hQ", function() gitsigns.setqflist("all") end)
				map("n", "<leader>hq", gitsigns.setqflist)
				-- Toggles
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
				map("n", "<leader>tw", gitsigns.toggle_word_diff)
				-- Text object
				map({"o", "x"}, "ih", gitsigns.select_hunk)
			end,
			-- vim.keymap.set("n", "<leader>ha", ":Gitsigns preview_hunk_inline<CR>", { desc = "Toogle Git preview hunk inline" })
			-- vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle Git Blame" })
		})
		vim.opt.foldcolumn = "0"
	end,
}
