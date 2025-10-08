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
-- vim.cmd("luafile ~/.config/nvim/lua/config/shorcuts.lua")

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

-- in your init.lua
vim.api.nvim_create_autocmd("SessionLoadPost", {
	callback = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) then
				-- Force filetype detection
				vim.api.nvim_buf_call(buf, function()
					vim.cmd("filetype detect")
				end)
			end
		end
	end,
})


vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function(event)
		-- vim.cmd([[hi LspDiagnosticsDefaultError guifg=BrightRed]])
		-- vim.cmd([[hi LspDiagnosticsDefaultWarning guifg=BrightYellow]])
		-- vim.cmd([[hi DiagnosticHint guifg=#ffff00]]) para unused vars y cosas asi
		vim.cmd([[hi DiagnosticWarn guifg=#ffff00]])
		vim.cmd([[hi NoiceFormatLevelWarn guifg=#f79000]]) -- para el primer mensaje de noice history Warn 19:29:12 notify.warn
		vim.cmd([[hi NotifyWARNBorder guifg=#f79000]]) -- esto es para los popups de arriba a la derecha
		vim.cmd([[hi NotifyWARNIcon guifg=#f79000]])
		vim.cmd([[hi NotifyWARNTitle guifg=#f79000]])
		vim.cmd([[hi WarningMsg guifg=#f79000]])
	end,
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	callback = function()
-- 		-- vim.cmd([[hi LspDiagnosticsDefaultError guifg=BrightRed]])
-- 		-- vim.cmd([[hi LspDiagnosticsDefaultWarning guifg=BrightYellow]])
-- 		vim.cmd([[hi DiagnosticWarn guifg=#ffff00]])
-- 		vim.cmd([[hi NoiceFormatLevelWarn guifg=#f79000]])
-- 		vim.cmd([[hi NotifyWARNBorder guifg=#f79000]])
-- 		vim.cmd([[hi NotifyWARNIcon guifg=#f79000]])
-- 		vim.cmd([[hi NotifyWARNTitle guifg=#f79000]])
-- 	end,
-- })
