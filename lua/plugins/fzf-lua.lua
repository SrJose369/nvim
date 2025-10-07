-- ================================================================================================
-- TITLE : fzf-lua
-- LINKS :
--   > github : https://github.com/ibhagwan/fzf-lua
-- ABOUT : lua-based fzf wrapper and integration.
-- ================================================================================================

return {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            desc = "FZF Files",
        },
        {
            "<leader>fg",
            function()
                require("fzf-lua").live_grep()
            end,
            desc = "FZF Live Grep",
        },
        {
            "<leader>rg",
            ":FzfLua live_grep resume=true<CR>",
            desc = "FZF Live Grep resume",
        },
        {
            "<leader>fr",
            function()
                require("fzf-lua").resume()
            end,
            desc = "FZF Live resume",
        },
        {
            "<leader>fb",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "FZF Buffers",
        },
        {
            "<leader>fh",
            function()
                require("fzf-lua").help_tags()
            end,
            desc = "FZF Help Tags",
        },
        {
            "<leader>fx",
            function()
                require("fzf-lua").diagnostics_document()
            end,
            desc = "FZF Diagnostics Document",
        },
        {
            "<leader>fX",
            function()
                require("fzf-lua").diagnostics_workspace()
            end,
            desc = "FZF Diagnostics Workspace",
        },
        {
            "<leader>fs",
            function()
                require("fzf-lua").lsp_document_symbols()
            end,
            desc = "FZF Document Symbols",
        },
        {
            "<leader>fS",
            function()
                require("fzf-lua").lsp_workspace_symbols()
            end,
            desc = "FZF Workspace Symbols",
        },
        {
            "<leader>k",
            function()
                require("fzf-lua").keymaps()
            end,
            desc = "Fzf Keymaps",
        }
    },

    opts = {},
}
