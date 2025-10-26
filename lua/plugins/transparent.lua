return {
	"xiyaowong/transparent.nvim",
	enabled = true,
	lazy = false,
	priority = 1000,
	dependencies = {
		-- "folke/tokyonight.nvim",
		-- "rose-pine/neovim",
		-- "mofiqul/vscode.nvim",
		{
			"edeneast/nightfox.nvim",
			config = function()
				require("nightfox").setup({
					specs = {
						carbonfox = {
							diag = {
								warn = "#f79000",
							},
						},
					},
					groups = {
						all = {
							MatchParen = {fg = "palette.magenta"},
							-- LspReferenceText = {fg="#dddddd", bg = "#3535c8"},
							LspReferenceText = {fg="#dddddd", bg = "#3535bb"},
							Visual = {bg = "#555555"},
							Folded = {bg="NONE"},
						},
					},
				})
			end
		},
	},
	config = function()
		vim.cmd("colorscheme carbonfox")
		vim.cmd([[hi NormalFloat guifg=#d4d6d8 guibg=NONE blend=0]])
		vim.cmd([[hi FloatBorder guibg=NONE blend=0]])
		require("transparent").setup({
			groups = {
				"NormalFloat",
				"NvimTreeNormal",
			},
			extra_groups = {},
			exclude_groups = {},
		})
	end,
}
