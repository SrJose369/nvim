-- ================================================================================================
-- TITLE : lazy.nvim Bootstrap & Plugin Setup
-- ABOUT :
--   bootstraps the 'lazy.nvim' plugin manager by cloning it if not present, prepends it to the
--   runtime path, and then loads core configuration files (globals, options, keymaps, autocmds).
--   Last, initialises 'lazy.nvim' with plugins.
-- LINKS :
--   > lazy.nvim github  : https://github.com/folke/lazy.nvim
--   > lazy.nvim website : https://lazy.folke.io/installation
-- ================================================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field (fs_stat)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("config.globals")
require("config.options")
require("config.keymaps")
require("config.autocmds")

local plugins_dir = "plugins"

require("lazy").setup({
	spec = {
		{ import = plugins_dir },
	},
	rtp = {
		disabled_plugins = {
			"netrw",
			"netrwPlugin",
		},
	},
	-- install = { colorscheme = { "tokyonight-night" } },
	checker = { enabled = true },
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- vim.cmd([[hi LspDiagnosticsDefaultError guifg=BrightRed]])
		-- vim.cmd([[hi LspDiagnosticsDefaultWarning guifg=BrightYellow]])
		-- vim.cmd([[hi DiagnosticHint guifg=#ffff00]]) -- para unused vars y cosas asi
		vim.cmd([[hi DiagnosticWarn guifg=#ffff00]])
		vim.cmd([[hi NoiceFormatLevelWarn guifg=#f79000]]) -- para el primer mensaje de noice history Warn 19:29:12 notify.warn
		vim.cmd([[hi NotifyWARNBorder guifg=#f79000]]) -- esto es para los popups de arriba a la derecha
		vim.cmd([[hi NotifyWARNIcon guifg=#f79000]])
		vim.cmd([[hi NotifyWARNTitle guifg=#f79000]])
		vim.cmd([[hi WarningMsg guifg=#f79000]])
		vim.cmd([[hi Lualine_x_diagnostics_warn_normal guifg=#f79000]])
		vim.cmd([[hi Visual guibg=#2a2a2a]])
		vim.cmd([[hi LspReferenceText guibg=#3b4252]])

		-- para que cmp quede transparente, tengo que hacerlo aca, sino queda negro, ademas tengo que setear las 3 cosas
		-- si no queda negro igual, el fg no importa como es transparente
		vim.cmd([[hi CmpPmenu guifg=#000000 guibg=NONE blend=0]])
		-- vim.cmd([[hi CmpPmenuSel guibg=NONE]])
		vim.cmd([[hi CmpPmenuBorder guifg=#dddddd guibg=NONE blend=0]])
		vim.cmd([[hi CmpDoc guifg=#000000 guibg=NONE blend=0]])
		vim.cmd([[hi CmpDocBorder guifg=#dddddd guibg=NONE blend=0]])
	end,
})
