-- ================================================================================================
-- TITLE : fzf-lua
-- LINKS :
--   > github : https://github.com/ibhagwan/fzf-lua
-- ABOUT : lua-based fzf wrapper and integration.
-- ================================================================================================

return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			grep = {
				rg_glob = true,
				-- pass globs using ripgrep's "-g" flag (you can change to "--iglob" if you want case-insensitive globs)
				glob_flag = "-g",
				glob_separator = "  ",
				rg_opts = table.concat({
					"--hidden",
					"--follow",
					"--line-number",
					"--column",
					"--no-heading",
					"--color=always",
					"--smart-case",
					"-F", -- exact (fixed string) match; swap to "-w" or "-x" if desired
				}, " "),
			},
		})
		local config = fzf.config
		vim.keymap.set("n", "<leader>k", function() fzf.keymaps() end, {desc = "Fzf Keymaps"})
		vim.keymap.set("n", "<leader>fa", function() fzf.builtin() end, {desc = "Fzf Builtin"})
		vim.keymap.set("n", "<leader>ff", function() fzf.files() end, {desc = "Fzf Files"})
		vim.keymap.set("n", "<leader>fg", function() fzf.live_grep() end, {desc = "Fzf Live Grep"})
		vim.keymap.set("n", "<leader>rg", function() fzf.live_grep({resume=true}) end, {desc = "Fzf Live Grep resume"})
		vim.keymap.set("n", "<leader>fr", function() fzf.resume() end, {desc = "Fzf Live resume"})
		vim.keymap.set("n", "<leader>fb", function() fzf.buffers() end, {desc = "Fzf Buffers"})
		vim.keymap.set("n", "<leader>fh", function() fzf.help_tags() end, {desc = "Fzf Help Tags"})
		vim.keymap.set("n", "<leader>fx", function() fzf.diagnostics_document() end, {desc = "Fzf Diagnostics Document"})
		vim.keymap.set("n", "<leader>fX", function() fzf.diagnostics_workspace() end, {desc = "Fzf Diagnostics Workspace"})
		vim.keymap.set("n", "<leader>fs", function() fzf.lsp_document_symbols() end, {desc = "Fzf Document Symbols"})
		vim.keymap.set("n", "<leader>fS", function() fzf.lsp_workspace_symbols() end, {desc = "Fzf Workspace Symbols"})

		vim.keymap.set("n", "<leader>gd", function() fzf.lsp_finder() end, {desc = "Fzf finder"}) -- LSP Finder (definition + references)
		vim.keymap.set("n", "<leader>gr", function() fzf.lsp_references() end, {desc = "Fzf references"})
		vim.keymap.set("n", "<leader>gt", function() fzf.lsp_typedefs() end, {desc = "Fzf Type Definition"})
		vim.keymap.set("n", "<leader>gi", function() fzf.lsp_implementations() end, {desc = "Fzf implementation"})

		vim.keymap.set("n", "<leader>fp", function()
			fzf.live_grep({
				prompt = "grep Packages",
				cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
			})
		end, {desc = "Fzf grep Packages"})
		vim.keymap.set("n", "<leader>fP", function()
			fzf.files({
				prompt = "files Packages",
				cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
			})
		end, {desc = "Fzf files Packages"})
		config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
	end,
}
