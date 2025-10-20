-- Custom luacheck diagnostics for none-ls (null-ls)
-- Drop this file somewhere in your runtimepath and require it from your none-ls setup.

local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

-- Map Luacheck codes to severities: E* -> error, W* -> warning
local severities = {
	E = helpers.diagnostics.severities.error,
	W = helpers.diagnostics.severities.warning,
}

-- Parses luacheck "plain" formatter lines like:
--   path.lua:3:7: (W211) unused variable 'x'
-- or with ranges (when --ranges is used):
--   path.lua:3:7-3:10: (W211) unused variable 'x'
local function parse_luacheck_line(line)
	-- Try with ranges first
	local row, col, end_row, end_col, code, message =
	line:match("^.-:(%d+):(%d+)%-(%d+):(%d+): %((%u%d+)%) (.+)$")
	if row then
		local sev_key = code:sub(1, 1)
		return {
			row = tonumber(row),
			col = tonumber(col),
			end_row = tonumber(end_row),
			end_col = tonumber(end_col),
			code = code,
			message = message,
			severity = severities[sev_key] or helpers.diagnostics.severities.warning,
			source = "luacheck",
		}
	end

	-- Fallback: no ranges in output
	row, col, code, message = line:match("^.-:(%d+):(%d+): %((%u%d+)%) (.+)$")
	if row then
		local sev_key = code:sub(1, 1)
		return {
			row = tonumber(row),
			col = tonumber(col),
			code = code,
			message = message,
			severity = severities[sev_key] or helpers.diagnostics.severities.warning,
			source = "luacheck",
		}
	end

	return nil
end

-- Define the custom builtin
local luacheck_custom = helpers.make_builtin({
	name = "luacheck_custom",
	meta = {
		url = "https://github.com/lunarmodules/luacheck",
		description = "Luacheck diagnostics via custom none-ls source.",
	},
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { "lua" },
	generator = null_ls.generator({
		command = "luacheck",
		to_stdin = true,
		-- Pass filename so Luacheck can apply per-file rules; read code and ranges for better positions
		args = {
			"--formatter", "plain",
			"--codes",
			"--ranges",
			"--filename", "$FILENAME",
			"-", -- read from stdin
		},
		format = "line",
		check_exit_code = function(code)
			-- Luacheck returns:
			-- 0: no warnings or errors
			-- 1: warnings
			-- 2: errors
			-- We still want diagnostics even if non-zero, so accept 0/1/2
			return code == 0 or code == 1 or code == 2
		end,
		on_output = function(line, _params)
			return parse_luacheck_line(line)
		end,
		runtime_condition = function(_params)
			-- Only run if luacheck is available
			return helpers.command_resolver.from_path("luacheck") ~= nil
		end,
	}),
})

-- Export a function to attach the source, preferring the builtin if it exists in your none-ls version
local M = {}

function M.within(sources)
	local has_builtin = null_ls.builtins
	and null_ls.builtins.diagnostics
	and null_ls.builtins.diagnostics.luacheck

	if has_builtin then
		table.insert(sources, null_ls.builtins.diagnostics.luacheck)
	else
		table.insert(sources, luacheck_custom)
	end
	return sources
end

return M
