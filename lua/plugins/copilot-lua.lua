return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = { enabled = false }, -- disable inline suggestions (we’ll use cmp)
            panel = { enabled = false },
        })
    end,
}
