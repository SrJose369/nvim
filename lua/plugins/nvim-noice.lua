return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		vim.api.nvim_set_hl(0, "MacroRecordingIcon", { fg = "#ec5f67", bold = true })
		vim.api.nvim_set_hl(0, "FileWrittenIcon",    { fg = "#98be65", bold = true })
		vim.api.nvim_set_hl(0, "UndoIcon",           { fg = "#98be65", bold = true })
		vim.api.nvim_set_hl(0, "CommandIcon",        { fg = "#98be65", bold = true })
		vim.api.nvim_set_hl(0, "YankIcon",           { fg = "#e5c07b", bold = true })
		vim.api.nvim_set_hl(0, "PasteIcon",          { fg = "#98be65", bold = true })
		vim.api.nvim_set_hl(0, "DeleteIcon",         { fg = "#ec5f67", bold = true })
		vim.api.nvim_set_hl(0, "ChangeIcon",         { fg = "#61afef", bold = true })
		vim.api.nvim_set_hl(0, "SubIcon",            { fg = "#56b6c2", bold = true })
		vim.api.nvim_set_hl(0, "JoinIcon",           { fg = "#c678dd", bold = true })
		vim.api.nvim_set_hl(0, "QuickfixIcon",       { fg = "#c678dd", bold = true })
		require("noice").setup({
			views = {
				cmdline_replace = {
					view = "cmdline",
					position = { row = "95%", col = "95%" },
					size = { width = 80, height = "auto" },
					-- you can keep other formatting defaults; if you want the same
					-- appearance as your current cmdline_popup, copy its opts here.
				},
				cmdline_popup = {
					position = { row = "35%", col = "50%" },
					size = { width = 60, height = "auto" },
				},
				mini_cmd = {
					view = "mini",
					timeout = 2000,
					align = "message-right",
					format = {
						{ "󰘳 ", hl_group = "CommandIcon" },
						"{message}",
					},
				},
				mini_undo = {
					view = "mini",
					timeout = 2000,
					format = {
						{ "󰑎 ", hl_group = "UndoIcon" },
						"{message}",
					},
				},
				mini_write = {
					view = "mini",
					timeout = 2000,
					format = {
						{ " ", hl_group = "FileWrittenIcon" },
						"{message}",
					},
				},
				mini_yank = {
					view = "mini",
					timeout = 2000,
					format = {
						{ " ", hl_group = "YankIcon" },
						"{message}",
					},
				},
				mini_paste = {
					view = "mini",
					timeout = 2000,
					format = {
						{ "󰆒 ", hl_group = "PasteIcon" },
						"{message}",
					},
				},
				mini_delete = {
					view = "mini",
					timeout = 2000,
					format = {
						{ " ", hl_group = "DeleteIcon" },
						"{message}",
					},
				},
				mini_change = {
					view = "mini",
					timeout = 2000,
					format = {
						{ " ", hl_group = "ChangeIcon" },
						"{message}",
					},
				},
				mini_sub = {
					view = "mini",
					timeout = 2000,
					format = {
						{ "󰛔 ", hl_group = "SubIcon" },
						"{message}",
					},
				},
				mini_join = {
					view = "mini",
					timeout = 2000,
					format = {
						{ " ", hl_group = "JoinIcon" },
						"{message}",
					},
				},
				mini_qf = {
					view = "mini",
					format = {
						{ "󱖫 ", hl_group = "QuickfixIcon" },
						"{message}",
					},
				},
				mini_plain = {
					view = "mini",
					format = { "{message}" },
				},
			},

			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					-- ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					-- ["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			hover = { enabled = true, view = nil },
			signature = { enabled = true, view = nil },
			documentation = { view = "hover" },
			routes = {
				{
					view = "cmdline",
					filter = { event = "msg_showmode", any = { { find = "recording" } } },
					opts = {
						format = {
							{ "󰑊", hl_group = "MacroRecordingIcon" },
							" ", "{message}"
						},
					},
				},
				{
					view = "cmdline",
					filter = {
						any = {
							-- match substitution commands like :s/, :%s/, 1,3s/
							{ event = "cmdline", find = "^:%s*[0-9,]*s/" },
							-- match the per-match confirm prompt that often contains "replace"
							-- Noice may surface that as msg_showcmd or msg_show depending on timing/plugins
							{ event = "msg_showcmd",  find = "[Rr]eplace" },
							{ event = "msg_show",     find = "[Rr]eplace with" },
							{find = "replace with"},
							-- optional: match other localized or different-wording prompts
							-- { event = "msg_showcmd", find = "confirm" },
						},
					},
					stop = true,
				},
				{
					view = "mini_cmd",
					filter = { event = "msg_showcmd" },
					stop = true,
				},
				{
					view = "mini_plain",
					filter = { event = "lsp", any = { { kind = "progress" }, { kind = "message" } } },
					stop = true,
				},
				{
					view = "mini_undo",
					filter = {
						event = "msg_show",
						any = {
							{ kind = "undo" },
							{ find = "Nothing to undo" },
							{ find = "Nothing to redo" },
							{ find = "Already at newest change" },
							{ find = "Already at oldest change" },
						},
					},
					stop = true,
				},
				{
					view = "mini_write",
					filter = {
						event = "msg_show",
						any = {
							{ kind = "bufwrite" },
							{ find = "^%d+L, %d+B written$" },
							{ find = "^Wrote " },
							{ find = "written" },
						},
					},
					stop = true,
				},
				{
					view = "mini_yank",
					filter = {
						event = "msg_show",
						any = {
							{ find = "^%d+ lines? yanked$" },
							{ find = " yanked$" },
						},
					},
					stop = true,
				},
				{
					view = "mini_paste",
					filter = {
						event = "msg_show",
						any = {
							{ find = "^%d+ more lines?$" },
						},
					},
					stop = true,
				},
				{
					view = "mini_delete",
					filter = {
						event = "msg_show",
						any = {
							{ find = "^%d+ fewer lines?$" },
						},
					},
					stop = true,
				},
				{
					view = "mini_join",
					filter = {
						event = "msg_show",
						any = {
							{ find = "^%d+ lines? joined$" },
						},
					},
					stop = true,
				},
				{
					view = "mini_change",
					filter = {
						event = "msg_show",
						any = {
							{ find = "^%d+ lines? changed$" },
						},
					},
					stop = true,
				},
				{
					view = "mini_sub",
					filter = {
						event = "msg_show",
						any = {
							{ find = "^%d+ substitutions? on %d+ lines?$" },
							{ find = "^%d+ substitutions?$" },
						},
					},
					stop = true,
				},
				{
					view = "mini_qf",
					filter = {
						event = "msg_show",
						any = {
							{ kind = "quickfi" },
						},
					},
					stop = true,
				},
				{
					view = "mini_qf",
					filter =  {
						event = "msg_show",
						any = {
							{ kind = "emsg", find = "E553:" },
						},
					},
					stop = true,
				},
				-- {
				-- 	view = "virtualtext",
				-- 	filter = {
				-- 		event = "msg_show",
				-- 		any = {
				-- 			{kind = "search_cmd"},
				-- 			{kind = "search_count"},
				-- 			{find="^/"},
				-- 			{find="^?"},
				-- 		},
				-- 	},
				-- 	stop = true,
				-- },
				-- { view = "notify", filter = { event = "msg_show" } },
				-- { view = "notify", filter = { event = "msg_showcmd" } },
			},
		})

		require("notify").setup({
			background_colour = "#000000",
		})
	end,
}
