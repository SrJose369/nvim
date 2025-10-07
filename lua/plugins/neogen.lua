-- Smart Neogen trigger
local function smart_neogen()
	local line = vim.api.nvim_get_current_line()
	-- Trim leading whitespace
	local trimmed = line:match("^%s*(.*)")
	if trimmed:match("^function") or line:find("%(") then
		-- If line starts with "function" or contains "(" → assume it's a function
		require("neogen").generate({ type = "func" })
	else
		-- Fallback: generic doc generation (class, type, etc.)
		require("neogen").generate()
	end
end

return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	cmd = "Neogen",
	keys = {
		{ "<leader>jd", smart_neogen, desc = "Generate doc comment" },
	},
	config = function()
		require("neogen").setup({
-- 			languages = {
-- 				typescript = {
-- 					template = {
-- 						annotation_convention = "jsdoc"
-- 					}
-- 				}
-- 			},
-- 			snippet_engine = "luasnip"
		})
	end
}
