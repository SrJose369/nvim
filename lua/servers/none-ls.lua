return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- C / C++
				-- null_ls.builtins.diagnostics.cpplint,
				-- null_ls.builtins.formatting.clang_format,
				-- Docker
				-- null_ls.builtins.diagnostics.hadolint,
				-- Go
				-- null_ls.builtins.diagnostics.revive,
				-- null_ls.builtins.formatting.gofumpt,
				-- Web / frontend
				null_ls.builtins.formatting.eslint_d, -- prettier_d → prettierd
				null_ls.builtins.diagnostics.eslint_d,
				-- JSON
				-- null_ls.builtins.formatting.fixjson,
				-- Lua
				null_ls.builtins.diagnostics.luacheck,
				null_ls.builtins.formatting.stylua,
				-- Python
				-- null_ls.builtins.diagnostics.flake8,
				-- null_ls.builtins.formatting.black,
				-- Shell
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.formatting.shfmt,
				-- Solidity
				-- null_ls.builtins.diagnostics.solhint,
			},
		})
	end,
}
