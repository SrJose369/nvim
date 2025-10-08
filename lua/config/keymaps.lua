-- ================================================================================================
-- TITLE: NeoVim keymaps
-- ABOUT: sets some quality-of-life keymaps
-- ================================================================================================

vim.keymap.set({"n", "v"}, "<leader>gg", "G", { desc = "G" })
vim.keymap.set("n", "<leader>v", "V", { desc = "V" })

vim.keymap.set("v", "yy", "y", { desc = "Copy selection" })
vim.keymap.set("v", "yc", '"+y', { desc = "Copy to ClipBoard" })
vim.keymap.set("n", "yp", '"+p', { desc = "Paste from ClipBoard" })

vim.keymap.set("n", "<A-u>", "<C-d>", { desc = "Page down (centered)" })
vim.keymap.set("n", "<A-i>", "<C-u>", { desc = "Page down (centered)" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", "<Cmd>e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- File Explorer
-- vim.keymap.set("n", "<leader>m", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus on File Explorer" })
vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "close file" })
vim.keymap.set("n", "<leader>i", "gg=G``zz", { desc = "Indent file" })

vim.keymap.set("v", "<leader>so", ":sort<CR>", { desc = "Sort selected lines" })

vim.keymap.set("n", "<S-u>", "<C-R>", { desc = "Redo" })
vim.keymap.set("n", "<C-u>", "u", { desc = "Redo" })

vim.keymap.set("n", "<leader>h", "<Cmd>nohlsearch<CR>", { desc = "Toggle search highlight" })

-- vim.keymap.set("n", "<leader>na", "<cmd>Noice all<CR>", {desc = "Noice Last Message" })
vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<CR>", {desc = "Noice Last Message" })
vim.keymap.set("n", "<leader>nh", "<cmd>Noice all<CR>", {desc = "Noice History" })
vim.keymap.set("n", "<leader>nf", "<cmd>Noice fzf<CR>", {desc = "Noice Fzf" })
vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<CR>", {desc = "Noice Dismiss" })
vim.keymap.set("n", "<leader>nc", "<cmd>Noice cmdline<CR>", {desc = "Noice Commandline" })

vim.keymap.set({"n", "v"}, "<leader>dd", '"_dd', { desc = "Delete line (no yank)" })

-- vim.keymap.set('n', '<leader>fp', ':ProjectFzf<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>la", function() print(vim.fn.expand("%:p")) end, { desc = "Show full path of current file" })
vim.keymap.set("n", "<leader>lr", function() print(vim.fn.expand("%")) end, { desc = "Show relative path of current file" })


vim.keymap.set("n", "<leader>m", function()
	local api = require("nvim-tree.api")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_win_get_buf(win)
	local ft = vim.api.nvim_buf_get_option(buf, "filetype")
	if ft == "NvimTree" then
		vim.cmd("wincmd p")
	else
		api.tree.focus()
	end
end, { desc = "Toggle focus between editor and NvimTree" })

-- Toggle maximize current split with <C-m>
vim.keymap.set("n", "<C-m>", function()
	if vim.t.maximized then
		-- restore previous view
		vim.cmd(vim.t.maximized_cmd)
		vim.t.maximized = false
	else
		-- save current layout
		vim.t.maximized_cmd = vim.fn.winrestcmd()
		vim.cmd("wincmd |")
		vim.cmd("wincmd _")
		vim.t.maximized = true
	end
end, { desc = "Toggle maximize current split" })

vim.keymap.set("n", "<A-o>", function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.cmd("bprevious")
	vim.cmd("bdelete " .. bufnr)
end, { desc = "Close buffer and return to previous" })

local buf_history, idx = {}, 0
local max_history = 50
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local b = vim.fn.bufname("%")
		if b ~= "" and buf_history[#buf_history] ~= b then
			table.insert(buf_history, b)
			-- Trim if over limit
			if #buf_history > max_history then
				table.remove(buf_history, 1)
			end
			idx = #buf_history
		end
	end,
})
vim.keymap.set("n", "S-h", function()
	if idx > 1 then
		idx = idx - 1
		vim.cmd("edit " .. buf_history[idx])
	end
end, { desc = "Back in buffer history" })
vim.keymap.set("n", "S-l", function()
	if idx < #buf_history then
		idx = idx + 1
		vim.cmd("edit " .. buf_history[idx])
	end
	end, { desc = "Forward in buffer history" })


vim.keymap.set("n", "gh", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local line = vim.fn.line('.') - 1
	local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })

	local contents = {}

	-- Build diagnostic lines: icon + code: + message
	for _, d in ipairs(diagnostics) do
		local icon = ""
		if d.severity == vim.diagnostic.severity.ERROR then
			icon = " "
		elseif d.severity == vim.diagnostic.severity.WARN then
			icon = " "
		elseif d.severity == vim.diagnostic.severity.INFO then
			icon = " "
		elseif d.severity == vim.diagnostic.severity.HINT then
			icon = "󰌵 "
		end

		local tag = d.code or d.source
		local label = tag and (tag .. ": ") or ""

		table.insert(contents, icon .. label .. d.message)
	end

	-- Request hover info
	local params = vim.lsp.util.make_position_params()
	vim.lsp.buf_request(bufnr, "textDocument/hover", params, function(err, result, ctx, _)
		if err then return end

		if result and result.contents then
			local hover_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
			hover_lines = vim.lsp.util.trim_empty_lines(hover_lines)
			if not vim.tbl_isempty(hover_lines) then
				if #contents > 0 then
					table.insert(contents, "")
				end
				vim.list_extend(contents, hover_lines)
			end
		end

		if not vim.tbl_isempty(contents) then
			local float_buf, _ = vim.lsp.util.open_floating_preview(contents, "markdown", { border = "rounded" })

			-- Highlight diagnostics lines
			for i, d in ipairs(diagnostics) do
				local hl = "Normal"
				if d.severity == vim.diagnostic.severity.ERROR then
					hl = "DiagnosticError"
				elseif d.severity == vim.diagnostic.severity.WARN then
					hl = "DiagnosticWarn"
				elseif d.severity == vim.diagnostic.severity.INFO then
					hl = "DiagnosticInfo"
				elseif d.severity == vim.diagnostic.severity.HINT then
					hl = "DiagnosticHint"
				end
				vim.api.nvim_buf_add_highlight(float_buf, -1, hl, i - 1, 0, -1)

				-- Force the code: prefix to Normal (white)
				if d.code or d.source then
					local tag = (d.code or d.source) .. ":"
					local line_text = vim.api.nvim_buf_get_lines(float_buf, i - 1, i, false)[1]
					local start_col = line_text:find(tag, 1, true)
					if start_col then
						vim.api.nvim_buf_add_highlight(float_buf, -1, "Normal", i - 1, start_col - 1, start_col - 1 + #tag)
					end
				end
			end
		end
	end)
end, { desc = "JetBrains-style hover with icon + code: + message" })
