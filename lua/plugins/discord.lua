-- return {
-- 	"andweeb/presence.nvim",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		require("presence").setup({
-- 			-- General options
-- 			auto_update         = true,                       -- Update activity automatically
-- 			neovim_image_text   = "The One True Text Editor", -- Hover text for the Neovim icon
-- 			main_image          = "neovim",                   -- "neovim" or "file"
-- 			debounce_timeout    = 10,                         -- Debounce updates (seconds)
-- 			enable_line_number  = false,                      -- Show line number in status
-- 			blacklist           = {},                         -- Disable presence in these dirs/files
-- 			buttons             = true,                       -- Show buttons (can be table for custom)
--
-- 			-- Rich Presence text options
-- 			editing_text        = "Editing %s",               -- %s = filename
-- 			file_explorer_text  = "Browsing %s",              -- %s = file explorer
-- 			git_commit_text     = "Committing changes",
-- 			plugin_manager_text = "Managing plugins",
-- 			reading_text        = "Reading %s",
-- 			workspace_text      = "Working on %s",            -- %s = project/workspace
-- 			line_number_text    = "Line %s out of %s",        -- %s = current line / total lines
-- 		})
-- 	end,
-- }

return {
	"vyfor/cord.nvim",
	event = "VeryLazy",
	opts = {
		-- client = {
		-- 	socket_path = "/tmp/discord-ipc-0", -- WSL2 bridge target
		-- },
		editor = {
			name = "Neovim",
			-- large_file_cutoff = 5000000, -- bytes
			show_line_number = true,
		},
		workspace = {
			detection_methods = { "lsp", "pattern" },
			patterns = { ".git", "lua", "src", "Makefile" },
		},
		-- presence = {
		-- 	editing = {
		-- 		details = "Editing %s",
		-- 		state = "Workspace: %s",
		-- 	},
		-- 	reading = {
		-- 		details = "Reading %s",
		-- 		state = "Workspace: %s",
		-- 	},
		-- 	browsing = {
		-- 		details = "Browsing files",
		-- 		state = "Workspace: %s",
		-- 	},
		-- 	managing_plugins = {
		-- 		details = "Managing plugins",
		-- 		state = "LazyVim setup",
		-- 	},
		-- 	idle = {
		-- 		details = "Idle in Neovim",
		-- 		state = "Thinking...",
		-- 	},
		-- },
	},
}

