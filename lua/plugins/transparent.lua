return {
	"xiyaowong/transparent.nvim",
	enabled = true,
	dependencies = {
		"hrsh7th/nvim-cmp",
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
							LspReferenceText = {bg = "#3535bb"},
							Visual = {bg = "#555555"},
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
