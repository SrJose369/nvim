return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		"zbirenbaum/copilot.lua",
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	opts = {
		debug = false,
		model = "gpt-5",
	},
	config = function(_, opts)
		require("CopilotChat").setup(opts)
		vim.keymap.set("n", "<leader>lc", function()
			require("CopilotChat").toggle()
		end, { desc = "Copilot Chat: Toggle panel" })
		vim.keymap.set({ "n", "v" }, "<leader>le", function()
			require("CopilotChat").explain()
		end, { desc = "Copilot Chat: Explain code" })
		vim.keymap.set({ "n", "v" }, "<leader>lf", function()
			require("CopilotChat").fix()
		end, { desc = "Copilot Chat: Suggest a fix" })
		vim.keymap.set({ "n", "v" }, "<leader>lo", function()
			require("CopilotChat").optimize()
		end, { desc = "Copilot Chat: Optimize/Refactor" })
		vim.keymap.set({ "n", "v" }, "<leader>lt", function()
			require("CopilotChat").tests()
		end, { desc = "Copilot Chat: Generate tests" })
	end,
}
