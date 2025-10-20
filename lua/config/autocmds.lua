-- ================================================================================================
-- TITLE : auto-commands
-- ABOUT : automatically run code on defined events (e.g. save, yank)
-- ================================================================================================
local on_attach = require("utils.lsp").on_attach

-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = last_cursor_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Highlight the yanked text for 200ms
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- format on save using efm langserver and configured formatters
-- local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = lsp_fmt_group,
--     callback = function()
--         local efm = vim.lsp.get_clients({ name = "efm" })
--         if vim.tbl_isempty(efm) then
--             return
--         end
--         vim.lsp.buf.format({ name = "efm", async = true })
--     end,
-- })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("servers.jdtls").setup()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typescript, typescriptreact, javascript, javascriptreact",
	callback = function()
		require("colors.ts")
	end,
})

vim.keymap.set("n", "<leader>fc", function()
	local parser = vim.treesitter.get_parser(0, "java")
	if parser == nil then return end
	local tree = parser:parse()[1]
	local root = tree:root()
	local query = vim.treesitter.query.parse("java", [[
	(block_comment) @c
	]])
	for _, node in query:iter_captures(root, 0, 0, -1) do
		local start_row, _, end_row, _ = node:range()
		vim.cmd(string.format("%d,%dfold", start_row + 1, end_row + 1))
	end
end, {desc = "Fold all comments"})

vim.keymap.set("n", "z2", function()
	local parser = vim.treesitter.get_parser(0, "java")
	if parser == nil then return end
	local tree = parser:parse()[1]
	local root = tree:root()
	local query = vim.treesitter.query.parse("java", [[
	(class_body) @b
	(method_declaration body: (block) @b)
	(constructor_body) @b
	(interface_body) @b
	(enum_body) @b
	(block_comment) @b
	]])
	for _, node in query:iter_captures(root, 0, 0, -1) do
		local parent = node:parent()
		local start_row, _, end_row, _ = node:range()
		if not (parent and parent:type() == "class_declaration" and parent:parent() == root) then
			vim.cmd(string.format("%d,%dfold", start_row + 1, end_row + 1))
		end
	end
end, {desc = "Fold level 2"})

-- on attach function shortcuts
local lsp_on_attach_group = vim.api.nvim_create_augroup("LspMappings", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_on_attach_group,
	callback = on_attach,
})
