-- ================================================================================================
-- TITLE : lualine.nvim
-- LINKS :
--   > github : https://github.com/nvim-lualine/lualine.nvim
-- ABOUT : A blazing fast and easy to configure Neovim statusline written in Lua.
-- ================================================================================================

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                -- theme = "tokyonight-night",
                icons_enabled = true,
                section_separators = { left = "", right = "" },
                component_separators = "|",
                globalstatus = true,
                disabled_filetypes = { "alpha", "dashboard", "neo-tree", "notify" },
            },
            sectons = {
                lualne_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            winbar = { },
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
