return {
	"folke/noice.nvim",
	evnet = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		vim.api.nvim_set_hl(0, "MacroRecordingIcon", { fg = "#ec5f67", bold = true })
		vim.api.nvim_set_hl(0, "FileWrittenIcon", { fg = "#98be65", bold = true })
		require("noice").setup({
			views = {
				cmdline_popup = {
					position = {
						row = "35%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			routes = {
				{

					view = "cmdline",
					filter = {
						event = "msg_showmode",
						any = { { find = "recording" } }
					},
					opts = {
						format = {
							{ "󰑊", hl_group = "MacroRecordingIcon" },
							" ", "{message}"
						},
					},
				},
				{
					view = "mini",
					filter = {
						event = "msg_show",
						any = { { find = "written" } },
					},
					opts = {
						format = {
							"{message}",
						},
					},
				}
			}
		})
		-- vim.opt.laststatus = 3
		-- vim.opt.cmdheight = 0
		require("notify").setup({
			background_colour = "#000000",
		})
	end
}
