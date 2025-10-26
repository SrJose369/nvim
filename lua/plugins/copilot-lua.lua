return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "VeryLazy",
	opts = {
		suggestion = {
			enabled = true, -- disable inline suggestions (we’ll use cmp)
			auto_trigger = true,
			debounce = 75,
			keymap =  {
				accept = "<Tab>",
				next = "<C-j>",
				prev = "<C-k>",
			}
		},
		panel = { enabled = false },
	}
}
