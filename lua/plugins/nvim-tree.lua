-- ================================================================================================
-- TITLE : nvim-tree.lua
-- ABOUT : A file explorer tree for Neovim, written in Lua.
-- LINKS :
--   > github : https://github.com/nvim-tree/nvim-tree.lua
-- ================================================================================================

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		-- Remove background color from the NvimTree window (ui fix)
		-- vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
		-- vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { link = "Directory" })
		-- vim.api.nvim_set_hl(0, "NvimTreeFolderName", { link = "Directory" })
		require("nvim-tree").setup({
			filters = {
				dotfiles = false, -- Show hidden files (dotfiles)
				-- git_ignored = false,
			},
			view = {
				adaptive_size = true,
			},
			sync_root_with_cwd = true,
			-- respect_buf_cwd = true,
			-- update_focused_file.update_root = true,
		})
		-- vim.cmd([[
		-- 	:hi      NvimTreeExecFile    guifg=#ffa0a0
		-- 	" :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
		-- 	:hi      NvimTreeSymlink     guifg=Yellow  gui=italic
		-- 	:hi link NvimTreeImageFile   Title
		-- 	]])
	end,
}
