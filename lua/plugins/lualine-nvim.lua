-- ================================================================================================
-- TITLE : lualine.nvim
-- LINKS :
--   > github : https://github.com/nvim-lualine/lualine.nvim
-- ABOUT : A blazing fast and easy to configure Neovim statusline written in Lua.
-- ================================================================================================

local fun = function()
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })
	local counts = {}
	for _, buf in ipairs(bufs) do
		local ft = vim.bo[buf.bufnr].filetype
		counts[ft] = (counts[ft] or 0) + 1
	end
	local icons = require("nvim-web-devicons")
	local parts = {}
	for ft, count in pairs(counts) do
		local icon, icon_hl = icons.get_icon_by_filetype(ft, { default = true })
		if icon and icon_hl then
			table.insert(parts, string.format("%%#%s#%s%%#Normal# %d", icon_hl, icon, count))
		end
	end
	return table.concat(parts, "  ")
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	extensions = { "nvim-tree", "fugitive", "quickfix", "lazy" },
	config = function()
		local auto_theme_custom = require('lualine.themes.auto')
		auto_theme_custom.normal.c.bg = 'none'
		auto_theme_custom.insert.c.bg = 'none'
		auto_theme_custom.visual.c.bg = 'none'
		auto_theme_custom.command.c.bg = 'none'
		auto_theme_custom.terminal.c.bg = 'none'
		require("lualine").setup({
			options = {
				-- theme = "tokyonight-night",
				-- theme = "melange",
				theme = auto_theme_custom,
				icons_enabled = true,
				section_separators = { left = "", right = "" },
				component_separators = "|",
				globalstatus = true,
				disabled_filetypes = { "alpha", "dashboard", "neo-tree", "notify" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diff" },
				lualine_c = { { fun }, {
					"filename",
					path = 1,
					-- color = { bg = "none" }
				} },
				lualine_x = { {
					"diagnostics",
					-- color = { bg = "none" }
				} },
				lualine_y = { "encoding", "fileformat", "filetype" },
				lualine_z = { "location" },
			},
			winbar = {},
		})
	end,
}
