-- ================================================================================================
-- TITLE : nvim-lspconfig
-- ABOUT : Quickstart configurations for the built-in Neovim LSP client.
-- LINKS :
--   > github                  : https://github.com/neovim/nvim-lspconfig
--   > mason.nvim (dep)        : https://github.com/mason-org/mason.nvim
--   > efmls-configs-nvim (dep): https://github.com/creativenull/efmls-configs-nvim
--   > cmp-nvim-lsp (dep)      : https://github.com/hrsh7th/cmp-nvim-lsp
-- ================================================================================================

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} }, -- LSP/DAP/Linter installer & manager
		{
			"mason-org/mason-lspconfig.nvim", -- bridges mason.nvim with the lspconfig plugin
			enabled = true,
		},
		"hrsh7th/cmp-nvim-lsp",               -- nvim-cmp source for LSP-based completion
		-- "creativenull/efmls-configs-nvim",    -- Preconfigured EFM Language Server setups
	},
	opts = {
		diagnostics = {
			float = {
				border = "rounded",
			},
		},
	},
	config = function()
		require("utils.diagnostics")
		require("servers")
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"ts_ls",
				-- "eslint",
				"lua_ls",
			},
			automatic_installation = {
				exclude = {
					"jdtls", -- java
				}
			}
		})
	end,
}
