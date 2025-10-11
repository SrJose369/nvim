local M = {}

M.history = {}
M.max_len = 20

M.allowed_filetypes = {
	lua = true,
	python = true,
	sh = true,
	-- vim = true,
}

function M.push(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then return end
	local ft = vim.bo[bufnr].filetype
	if not M.allowed_filetypes[ft] then return end
	local c = #M.history
	for i, b in ipairs(M.history) do
		if b == bufnr then
			table.remove(M.history, i)
			break
		end
	end
	table.insert(M.history, bufnr)
end

function M.rotate_right()
	if #M.history > 1 then
		local last = table.remove(M.history)
		table.insert(M.history, 1, last)
		M.jump_to()
	end
end

function M.rotate_left()
	if #M.history > 1 then
		local first = table.remove(M.history, 1)
		table.insert(M.history, first)
		M.jump_to()
	end
end

function M.jump_to()
	local bufnr = M.history[#M.history]
	if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
		vim.api.nvim_set_current_buf(bufnr)
	else
		vim.notify("Invalid buffer in history", vim.log.levels.WARN)
	end
end

function M.print_history()
	local names = {}
	for _, b in ipairs(M.history) do
		local name = vim.api.nvim_buf_get_name(b)
		local short = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
		table.insert(names, b .. short)
	end
	print("History: " .. table.concat(names, " -> "))
end

vim.keymap.set("n", "<A-o>", function()
	if vim.bo.modified then
		vim.notify("Buffer modified, save before closing", vim.log.levels.WARN)
		return
	end
	local current = vim.api.nvim_get_current_buf()
	-- vim.cmd("buffer " .. prev)    -- switch to previous buffer
	-- vim.cmd("bprevious")
	vim.cmd("bdelete " .. current) -- then delete the old one
end, { desc = "Close buffer and return to previous" })

return M
