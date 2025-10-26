-- ================================================================================================
-- TITLE : nvim-tree.lua
-- ABOUT : A file explorer tree for Neovim, written in Lua.
-- LINKS :
--   > github : https://github.com/nvim-tree/nvim-tree.lua
-- ================================================================================================

return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			filters = {
				dotfiles = false,
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
