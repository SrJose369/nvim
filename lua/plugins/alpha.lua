return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		require("alpha.term")
		dashboard.section.terminal.command = "cat | " .. vim.fn.stdpath("config") .. "/lua/plugins/logo.sh -m"
		dashboard.section.terminal.width = 70
		dashboard.section.terminal.height = 10
		dashboard.section.terminal.opts.redraw = true
		dashboard.section.buttons.val = {
			dashboard.button("i", "  new file", ":ene <BAR> startinsert<CR>"),
			dashboard.button("r", "  recent files", ":FzfLua oldfiles<CR>"),
			dashboard.button("f", "󰥨  find file", ":FzfLua files<CR>"),
			dashboard.button("g", "󰱼  find text", ":FzfLua live_grep<CR>"),
			dashboard.button("l", "󰒲  lazy", ":Lazy<CR>"),
			dashboard.button("m", "󱌣  mason", ":Mason<CR>"),
			dashboard.button("q", "󰭿  quit", ":qa<CR>"),
		}
		dashboard.opts.layout = {
			{type = "padding", val = 6},
			dashboard.section.terminal,
			{type = "padding", val = 2},
			dashboard.section.buttons,
			dashboard.section.footer,
		}
		return dashboard
	end,
	config = function(_, dashboard)
		require("alpha").setup(dashboard.opts)
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = "⚡ " .. stats.count .. " plugins loaded in " .. ms .. "ms"
			end,
		})
	end,
}
