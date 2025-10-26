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
