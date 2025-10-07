local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

return {
	-- Trigger: af → Insert current date-time
	s("af", {
		f(function()
			-- Customize your format here
			return os.date("%Y-%m-%d %H:%M:%S") -- Example: 2025-10-03 12:13:00
		end),
	}),
}
