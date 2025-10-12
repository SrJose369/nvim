local M = {}
M.history = {}
M.pointer = 0
M.suppress = false
M.cap = 20
M.allowed = { lua = true, python = true, sh = true, vim = true } -- example

local function is_allowed(bufnr)
	local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
	return ft ~= "" and M.allowed[ft]
end

local function trim_left()
	while #M.history > M.cap do
		table.remove(M.history, 1)
		if M.pointer > 0 then
			M.pointer = M.pointer - 1
			if M.pointer < 0 then M.pointer = 0 end
		end
	end
end

function M.add(bufnr)
	if M.suppress then return end
	if not vim.api.nvim_buf_is_valid(bufnr) then return end
	if not is_allowed(bufnr) then return end
	if M.history[M.pointer] == bufnr then return end
	local n = #M.history
	if M.pointer < n then
		local end_idx = n
		local to_mirror = {}
		for i = end_idx - 1, M.pointer, -1 do
			table.insert(to_mirror, M.history[i])
		end
		for _, v in ipairs(to_mirror) do
			table.insert(M.history, v)
		end
	end
	table.insert(M.history, bufnr)
	M.pointer = #M.history
	trim_left()
end

function M.back()
	if M.pointer > 1 then
		M.pointer = M.pointer - 1
		local target = M.history[M.pointer]
		if target and vim.api.nvim_buf_is_valid(target) then
			M.suppress = true
			vim.api.nvim_set_current_buf(target)
			M.suppress = false
		end
	end
end

function M.forward()
	if M.pointer < #M.history then
		M.pointer = M.pointer + 1
		local target = M.history[M.pointer]
		if target and vim.api.nvim_buf_is_valid(target) then
			M.suppress = true
			vim.api.nvim_set_current_buf(target)
			M.suppress = false
		end
	end
end

-- optional helper: go to last history element
function M.goto_last()
	if #M.history > 0 then
		M.pointer = #M.history
		local target = M.history[M.pointer]
		if target and vim.api.nvim_buf_is_valid(target) then
			M.suppress = true
			vim.api.nvim_set_current_buf(target)
			M.suppress = false
		end
	end
end

-- autocmd to add BufEnter
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		-- args.buf is the entered buffer number in Neovim 0.7+
		local bufnr = args.buf or vim.api.nvim_get_current_buf()
		M.add(bufnr)
	end,
})

function M.print_history()
	local names = {}
	for _, b in ipairs(M.history) do
		local name = vim.api.nvim_buf_get_name(b)
		local short = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
		table.insert(names, b .. short)
	end
	vim.notify("pointer at: " .. M.pointer)
	vim.notify("History: " .. table.concat(names, "->"))
end

-- keymaps H and L
vim.keymap.set("n", "H", function() M.back() end, { desc = "Buffer history back" })
vim.keymap.set("n", "L", function() M.forward() end, { desc = "Buffer history forward" })
vim.keymap.set("n", "<leader>bh", function() M.print_history() end, { desc = "Buffer history" })

vim.keymap.set("n", "<A-o>", function()
	if vim.bo.modified then
		vim.notify("Buffer modified, save before closing", vim.log.levels.WARN)
		return
	end
	if #M.history <= 1 then return end
	local current = vim.api.nvim_get_current_buf()
	M.back()
	vim.cmd("bdelete " .. current)
end, { desc = "Close buffer and return to previous" })

return M
