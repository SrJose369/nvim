local M = {}

M.on_attach = function(event)
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if not client then
		return
	end
	local bufnr = event.buf
	local jdtls = require("jdtls")
	local abc = {
		noremap = true, -- prevent recursive mapping
		silent = true, -- don't print the command to the cli
		buffer = bufnr, -- restrict the keymap to the local buffer number
	}
	vim.keymap.set('n', '<leader>p', function()
		vim.lsp.buf.format({ async = true })
	end, { buffer = bufnr, desc = 'LSP Format File' })
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {noremap = true, buffer = bufnr, desc = "Signature Help"})
	vim.keymap.set("n", "<leader>gs", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", {noremap = true, buffer = bufnr, desc = "Goto definition Vsplit"})
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, {noremap = true, buffer = bufnr, desc = "Rename"})
	vim.keymap.set("n", "<leader>uws", function() vim.lsp.buf.workspace_symbol() end, {noremap = true, buffer = bufnr, desc = "Workspace Symbols"})
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover({border="rounded"}) end, {noremap = true, buffer = bufnr, desc = "Hover Documentation"})
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {noremap = true, buffer = bufnr, desc = "Goto definition"})
	vim.keymap.set("n", "ge", function() vim.diagnostic.open_float({ scope = "line" }) end, {noremap = true, buffer = bufnr, desc = "Line Diagnostics"}) -- Line diagnostics (float)
	vim.keymap.set("n", "gj", function() vim.lsp.buf.code_action() end, {noremap = true, buffer = bufnr, desc = "Code Action"})
	vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, {noremap = true, buffer = bufnr, desc = "Next Diagnostic"})
	vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, {noremap = true, buffer = bufnr, desc = "Prev Diagnostic"})
	vim.keymap.set("n", "gu", function() vim.lsp.buf.references() end, {noremap = true, buffer = bufnr, desc = "Goto References"})
	vim.keymap.set('n', '<leader>D', function() vim.lsp.buf.type_definition() end, {noremap = true, buffer = bufnr, desc = "Type Definition"})
	vim.keymap.set('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, {noremap = true, buffer = bufnr, desc = "Add workspace folder"})
	vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {noremap = true, buffer = bufnr, desc = "List workspace folders"})
	vim.keymap.set('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, {noremap = true, buffer = bufnr, desc = "Remove workspace folder"})
	vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, {noremap = true, buffer = bufnr, desc = "Declaration"})
	vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, {noremap = true, buffer = bufnr, desc = "implementation"})
	vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() vim.cmd("copen") end, {noremap = true, buffer = bufnr, desc = "References"})
	-- vim.keymap.set('n', '<leader>lq', function() vim.lsp.diagnostic.set_loclist() end, {noremap = true, buffer = bufnr, desc = "Loc List"})
	-- Java specific
	-- vim.keymap.set("n", "<leader>oi", function() require("jdtls").organize_imports() end, {noremap = true, buffer = bufnr, desc = "Organize Imports"})
	vim.keymap.set("n", "<leader>dt", function() jdtls.test_class() end, {noremap = true, buffer = bufnr, desc = "Test Class"})
	vim.keymap.set("n", "<leader>dn", function() jdtls.test_nearest_method() end, {noremap = true, buffer = bufnr, desc = "Test Nearest Method"})
	-- vim.keymap.set("v", "<leader>de", "<Esc><Cmd>lua jdtls.extract_variable(true)<CR>", {noremap = true, buffer = bufnr, desc = "Extract Variable visual"})
	-- vim.keymap.set("v", "<leader>dm", "<Esc><Cmd>lua jdtls.extract_method(true)<CR>", {noremap = true, buffer = bufnr, desc = "Extract Method"})
	vim.keymap.set("n", "<leader>de", function() jdtls.extract_variable() end, {noremap = true, buffer = bufnr, desc = "Extract Variable normal"})
	vim.keymap.set("v", "<leader>de", function() jdtls.extract_variable(true) end, {noremap = true, buffer = bufnr, desc = "Extract Variable visual"})
	vim.keymap.set("v", "<leader>dm", function() jdtls.extract_method(true) end, {noremap = true, buffer = bufnr, desc = "Extract Method"})

	-- Order Imports (if supported by the client LSP)
	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.organizeImports" },
					diagnostics = {},
				},
				apply = true,
				bufnr = bufnr,
			})
			-- format after changing import order
			-- vim.defer_fn(function()
			-- 	vim.lsp.buf.format({ bufnr = bufnr })
			-- end, 50) -- slight delay to allow for the import order to go first
		end, {noremap = true, buffer = bufnr, desc = "Organize Imports"})
	end
	-- === DAP keymaps ===
	if client.name == "rust-analyzer" or client.name == "jdtls" then -- debugging only configured for Rust
		local dap = require("dap")
		vim.keymap.set("n", "<leader>dc", dap.continue, {noremap = true, buffer = bufnr, desc = "Continue/Start"})
		vim.keymap.set("n", "<leader>do", dap.step_over, {noremap = true, buffer = bufnr, desc = "Step over"})
		vim.keymap.set("n", "<leader>di", dap.step_into, {noremap = true, buffer = bufnr, desc = "Step into"})
		vim.keymap.set("n", "<leader>du", dap.step_out, {noremap = true, buffer = bufnr, desc = "Step out"})
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {noremap = true, buffer = bufnr, desc = "Toggle breakpoint"})
		vim.keymap.set("n", "<leader>dr", dap.repl.open, {noremap = true, buffer = bufnr, desc = "Open DAP REPL"})
	end
end

return M
