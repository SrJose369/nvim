-- ================================================================================================
-- TITLE : mini.nvim
-- LINKS :
--   > github : https://github.com/echasnovski/mini.nvim
-- ABOUT : Library of 40+ independent Lua modules.
-- ================================================================================================

return {
    {
        "echasnovski/mini.ai",
        version = "*",
        opts = {},
        config = function()
            local ai = require("mini.ai")
            ai.setup({
                custom_textobjects = {
                    b = ai.gen_spec.pair("(", ")"),
                    r = ai.gen_spec.pair("[", "]"),
                    c = ai.gen_spec.pair("{", "}"),
                },
            })
        end,
    },
    {
        "echasnovski/mini.comment",
        version = "*",
        opts = {},
        config = function()
            require("mini.comment").setup({
                options = {
                    custom_commentstring = nil,
                    ignore_blank_line = false,
                    start_of_line = false,
                    pad_comment_parts = true,
                },
                mappings = {
                    comment = "gc",
                    comment_line = "gcc",
                    comment_visual = "gc",
                    textobject = "gc",
                },
                hooks = {
                    -- Before successful commenting. Does nothing by default.
                    pre = function() end,
                    -- After successful commenting. Does nothing by default.
                    post = function() end,
                },
            })
        end,
    },
    { "echasnovski/mini.move", version = "*", opts = {} },
    {
        "echasnovski/mini.surround",
        version = "*",
        opts = {},
        config = function()
            require("mini.surround").setup({
                custom_surroundings = {
                    r = {
                        input = {
                            "%b[]",               -- plain [ ... ]
                            "%[()%s*.-()%s*%]",   -- [   foo   ] with captures around inner text
                        },
                        output = { left = "[", right = "]" }
                    },
                    c = {
                        input = {
                            "%b{}",               -- plain [ ... ]
                            "%{()%s*.-()%s*%}",   -- [   foo   ] with captures around inner text
                        },
                        output = { left = "{", right = "}" }
                    }
                },
                highlight_duration = 500,
                mappings = {
                    add = "ys", -- Add surrounding in Normal and Visual modes
                    delete = "ds", -- Delete surrounding
                    find = "", -- Find surrounding (to the right)
                    find_left = "", -- Find surrounding (to the left)
                    highlight = "", -- Highlight surrounding
                    replace = "cs", -- Replace surrounding
                    suffix_last = "l", -- Suffix to search with "prev" method
                    suffix_next = "n", -- Suffix to search with "next" method
                },
                n_lines = 20,
                respect_selection_type = false,
                search_method = "cover",
                silent = false,
            })
            vim.keymap.del("n", "sn")
        end,
    },
    { "echasnovski/mini.cursorword", version = "*", opts = {} },
    { "echasnovski/mini.indentscope", version = "*", opts = {} },
    { "echasnovski/mini.pairs", version = "*", opts = {} },
    { "echasnovski/mini.trailspace", version = "*", opts = {} },
    { "echasnovski/mini.bufremove", version = "*", opts = {} },
    -- { "echasnovski/mini.notify", version = "*", opts = {} },
}
