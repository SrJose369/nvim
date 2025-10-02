-- ================================================================================================
-- TITLE : melange-nvim
-- ABOUT : A subtle, warm colorscheme for Neovim inspired by Sublime Text's Melange theme.
-- LINKS :
--   > github : https://github.com/savq/melange-nvim
-- ================================================================================================

return {
    "savq/melange-nvim",
    -- "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme melange")
        -- vim.cmd("colorscheme tokyonight-night")
        -- " There are also colorschemes for the different styles.
        -- colorscheme tokyonight-night
        -- colorscheme tokyonight-storm
        -- colorscheme tokyonight-day
        -- colorscheme tokyonight-moon
    end,
}
