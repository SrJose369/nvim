return {
	"nvimtools/none-ls.nvim",
	enabled = false,
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local sources = {
			-- C / C++
			-- require("none-ls.diagnostics.ccplint"),
			-- null_ls.builtins.formatting.clang_format,
			-- Docker
			-- null_ls.builtins.diagnostics.hadolint,
			-- Go
			-- null_ls.builtins.diagnostics.revive,
			-- null_ls.builtins.formatting.gofumpt,
			-- Web / frontend
			-- null_ls.builtins.formatting.eslint_d, -- prettier_d → prettierd
			-- require("none-ls.formatting.eslint"),
			-- require("none-ls.diagnostics.eslint"),
			-- require("none-ls.code_actions.eslint"),
			-- JSON
			-- null_ls.builtins.formatting.fixjson, X
			-- Lua
			-- require("servers.luacheck"),
			-- null_ls.builtins.diagnostics.luacheck, X
			null_ls.builtins.formatting.stylua,
			-- Python
			-- require("none-ls.diagnostics.flake8"),
			-- null_ls.builtins.formatting.black,
			-- Shell
			-- null_ls.builtins.diagnostics.shellcheck, X
			null_ls.builtins.formatting.shfmt,
			-- Solidity
			-- null_ls.builtins.diagnostics.solhint,
		}
		-- require("servers.luacheck").within(sources)
		null_ls.setup({
			debug = false,
			sources = sources,
		})
	end,
}
