return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		"zbirenbaum/copilot.lua",
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ mode="n"           , "<leader>lc", function() require("CopilotChat").toggle() end  , desc = "Copilot Chat: Toggle panel" },
		{ mode = { "n", "v" }, "<leader>le", function() require("CopilotChat").explain() end , desc = "Copilot Chat: Explain code" },
		{ mode = { "n", "v" }, "<leader>lf", function() require("CopilotChat").fix() end     , desc = "Copilot Chat: Suggest a fix" },
		{ mode = { "n", "v" }, "<leader>lo", function() require("CopilotChat").optimize() end, desc = "Copilot Chat: Optimize/Refactor" },
		{ mode = { "n", "v" }, "<leader>lt", function() require("CopilotChat").tests() end   , desc = "Copilot Chat: Generate tests" },
	},
	opts = {
		debug = false,
		model = "gpt-5",
	},
}
