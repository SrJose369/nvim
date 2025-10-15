local severity_hl = {
	[vim.diagnostic.severity.ERROR] = "DiagnosticError",
	[vim.diagnostic.severity.WARN]  = "DiagnosticWarn",
	[vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
	[vim.diagnostic.severity.HINT]  = "DiagnosticHint",
}
local severity_icon = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN]  = " ",
	[vim.diagnostic.severity.INFO]  = " ",
	[vim.diagnostic.severity.HINT]  = " ",
}

-- Disable default virtual_text to avoid duplicates
vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = {
		text = severity_icon,
	},
	update_in_insert = false,
})

local orig_signs = vim.diagnostic.handlers.signs

vim.diagnostic.handlers.signs = {
	show = function(namespace, bufnr, diagnostics, opts)
		local max_per_line = {}

		for _, d in ipairs(diagnostics) do
			local lnum = d.lnum
			if not max_per_line[lnum] or d.severity < max_per_line[lnum].severity then
				max_per_line[lnum] = d
			end
		end

		local filtered = {}
		for _, d in pairs(max_per_line) do
			table.insert(filtered, d)
		end

		-- Pass the correct args back
		orig_signs.show(namespace, bufnr, filtered, opts)
	end,
	hide = function(namespace, bufnr)
		orig_signs.hide(namespace, bufnr)
	end,
}

-- local ns = vim.api.nvim_create_namespace("inline_diagnostics")
-- -- Map severity to highlight group and icon
-- local function render_inline(bufnr)
-- 	-- Guard: buffer must exist and be loaded
-- 	if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
-- 		return
-- 	end
-- 	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
-- 	-- Collect diagnostics and choose highest severity per line
-- 	local diags = vim.diagnostic.get(bufnr)
-- 	if not diags or #diags == 0 then return end
-- 	local line_count = vim.api.nvim_buf_line_count(bufnr)
-- 	local by_line = {}
-- 	for _, d in ipairs(diags) do
-- 		local lnum = d.lnum
-- 		-- Guard: line index must be within buffer
-- 		if lnum >= 0 and lnum < line_count then
-- 			local prev = by_line[lnum]
-- 			if not prev or d.severity < prev.severity then
-- 				by_line[lnum] = d -- lower number = higher severity
-- 			end
-- 		end
-- 	end
-- 	for lnum, d in pairs(by_line) do
-- 		local hl = severity_hl[d.severity] or "DiagnosticVirtualTextInfo"
-- 		local icon = severity_icon[d.severity] or " "
-- 		local msg = d.message:gsub("\n", " ") -- keep it single-line
-- 		-- Use col = 0 (required by API), and place at EOL
-- 		vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, 0, {
-- 			virt_text = { { "  " .. icon .. msg, hl } },
-- 			virt_text_pos = "eol",
-- 			hl_mode = "combine",
-- 			priority = 200, -- render above most decorations
-- 		})
-- 	end
-- end
-- -- Debounced/scheduled render to avoid racing with edits
-- local schedule_render = vim.schedule_wrap(function(bufnr)
-- 	render_inline(bufnr)
-- end)
-- vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter", "BufWritePost" }, {
-- 	callback = function(args)
-- 		local bufnr = args.buf or vim.api.nvim_get_current_buf()
-- 		schedule_render(bufnr)
-- 	end,
-- })
-- -- Optional: refresh on mode change (skip Insert for less noise)
-- vim.api.nvim_create_autocmd("ModeChanged", {
-- 	pattern = "*:n", -- when returning to Normal mode
-- 	callback = function()
-- 		local bufnr = vim.api.nvim_get_current_buf()
-- 		schedule_render(bufnr)
-- 	end,
-- })
