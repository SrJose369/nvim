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
		{
			"mason-org/mason.nvim", opts = {} -- LSP/DAP/Linter installer & manager
		},
		"creativenull/efmls-configs-nvim",    -- Preconfigured EFM Language Server setups
		"hrsh7th/cmp-nvim-lsp",               -- nvim-cmp source for LSP-based completion
		"mason-org/mason-lspconfig.nvim",     -- bridges mason.nvim with the lspconfig plugin
		{
			"nvimtools/none-ls.nvim",
			dependencies = {
				"nvimtools/none-ls-extras.nvim",
				"nvim-lua/plenary.nvim",
			},
			config = function()
				local null_ls = require("null-ls")
				null_ls.setup({
					sources = {
						-- require("none-ls.diagnostics.eslint_d"),
						-- require("none-ls.code_actions.eslint_d"),
						-- require("none-ls.formatting.eslint_d"),
						-- null_ls.builtins.diagnostics.eslint_d,
						-- null_ls.builtins.code_actions.eslint_d,
						-- null_ls.builtins.formatting.eslint_d,
					},
				})
			end,
		}
	},
	config = function()
		require("utils.diagnostics").setup()
		require("servers")
		-- require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bash_ls",
				"ts_ls",
				-- "eslint",
				"lua_ls",
			},
		})
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- ESLint LSP for diagnostics + code actions
		-- vim.lsp.config("eslint", {
		-- 	capabilities = capabilities,
		-- 	settings = {
		-- 		-- optional: auto-fix on save via LSP
		-- 		format = true,
		-- 	},
		-- })
	end,
}
