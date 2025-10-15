return {
    "zbirenbaum/copilot-cmp",
	enbaled = false,
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
        require("copilot_cmp").setup()
    end,
}
