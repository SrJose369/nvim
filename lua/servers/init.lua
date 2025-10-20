local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Language Server Protocol (LSP)
require("servers.lua_ls")(capabilities)
-- require("servers.pyright")(capabilities)
-- require("servers.gopls")(capabilities)
-- require("servers.jsonls")(capabilities)
require("servers.ts_ls")(capabilities)
require("servers.bashls")(capabilities)
-- require("servers.clangd")(capabilities)
-- require("servers.dockerls")(capabilities)
-- require("servers.yamlls")(capabilities)
-- require("servers.tailwindcss")(capabilities)
-- require("servers.solidity_ls_nomicfoundation")(capabilities)
-- require("servers.efm-langserver")(capabilities)

-- ESLint LSP for diagnostics + code actions
-- vim.lsp.config("eslint", {
-- 	capabilities = capabilities,
-- 	settings = {
-- 		-- optional: auto-fix on save via LSP
-- 		format = true,
-- 	},
-- })

-- Linters & Formatters
vim.lsp.enable({
	'lua_ls',
	-- 'pyright',
	-- 'gopls',
	-- 'jsonls',
	'ts_ls',
	'bashls',
	-- "null-ls",
	-- "efm",
	-- 'clangd',
	-- 'dockerls',
	-- 'yamlls',
	-- 'tailwindcss',
	-- 'solidity_ls_nomicfoundation',
})
