-- ================================================================================================
-- TITLE : nvim-cmp
-- ABOUT : A completion plugin written in lua.
-- LINKS :
--   > github                             : https://github.com/hrsh7th/nvim-cmp
--   > lspkind (dep)                      : https://github.com/onsails/lspkind.nvim
--   > cmp_luasnip (dep)                  : https://github.com/saadparwaiz1/cmp_luasnip
--   > luasnip (dep)                      : https://github.com/L3MON4D3/LuaSnip
--   > friendly-snippets (dep)            : https://github.com/rafamadriz/friendly-snippets
--   > cmp-nvim-lsp (dep)                 : https://github.com/hrsh7th/cmp-nvim-lsp
--   > cmp-buffer (dep)                   : https://github.com/hrsh7th/cmp-buffer
--   > cmp-path (dep)                     : https://github.com/hrsh7th/cmp-path
--   > cmp-nvim-lsp-signature-help (dep)  : https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
-- ================================================================================================

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"onsails/lspkind.nvim", -- Adds VS Code-like pictograms/icons to the completion menu
		"saadparwaiz1/cmp_luasnip", -- Enables LuaSnip as a source for nvim-cmp autocompletion
		"L3MON4D3/LuaSnip", -- Snippet engine for Neovim (write and expand code snippets)
		"rafamadriz/friendly-snippets", -- Large collection of pre-made snippets for various languages
		"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for LSP-based autocompletion
		"hrsh7th/cmp-buffer", -- nvim-cmp source for words from the current buffer
		"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths
		"hrsh7th/cmp-cmdline", -- nvim-cmp source for command line mode
		"hrsh7th/cmp-nvim-lsp-signature-help", -- function signatures
	},
	config = function()
		local lspkind = require("lspkind")
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_lua").lazy_load({
			include = { "all" },
			paths = "~/.config/nvim/lua/snippets",
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
		})
		-- vim.api.nvim_create_autocmd("ColorScheme", {
		-- 	callback = function()
		-- 		vim.api.nvim_set_hl(0, "Pmenu",       { bg = "None", fg = "green" })
		-- 		vim.api.nvim_set_hl(0, "PmenuSel",    { bg = "None", fg = "pink"})
		-- 		vim.api.nvim_set_hl(0, "PmenuBorder", { bg = "None", fg = "pink" })
		-- 		vim.api.nvim_set_hl(0, "DocBorder",   { bg = "None", fg = "yellow" })
		-- 	end
		-- })
		cmp.setup({
			-- window = {
			-- 	completion = cmp.config.window.bordered({
			-- 		winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
			-- 	}),
			-- 	documentation = cmp.config.window.bordered({
			-- 		winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			-- 	}),
			-- },
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			formatting = {
				format = lspkind.cmp_format({
					before = require("tailwind-tools.cmp").lspkind_format,
					mode = "symbol_text",
					menu = {
						copilot = "",
						-- codeium = "",
						luasnip = "",
						buffer = "",
						path = "",
						nvim_lsp = "🅻",
					},
				}),
			},

			vim.keymap.set({"i"}, "<C-K>", function() luasnip.expand() end, {silent = true}),
			vim.keymap.set({"i", "s"}, "<Tab>", function() luasnip.jump( 1) end, {silent = true}),
			vim.keymap.set({"i", "s"}, "<S-Tab>", function() luasnip.jump(-1) end, {silent = true}),
			vim.keymap.set({"i", "s"}, "<C-E>", function()
				if luasnip.choice_active() then
					luasnip.change_choice(1)
				end
			end, {silent = true}),

			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				-- ["<Tab>"] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_next_item()
				-- 	elseif luasnip.expand_or_jumpable() then
				-- 		luasnip.expand_or_jump()
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { "i", "s" }),
				-- ["<S-Tab>"] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_prev_item()
				-- 	elseif luasnip.jumpable(-1) then
				-- 		luasnip.jump(-1)
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { "i", "s" }),
			}),

			sources = {
				{ name = "copilot" },
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "nvim_lsp_signature_help" },
			},
		})
	end,
}
