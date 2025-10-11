return {
    "jake-stewart/multicursor.nvim",
    event = "VeryLazy",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()
        local set = vim.keymap.set
        set({"n"}, "<A-j>", function() mc.lineAddCursor(1) end)
        set({"n"}, "<A-k>", function() mc.lineSkipCursor(-1) end)
        set({"n", "x"}, "<A-n>", function() mc.matchAddCursor(1) end)
        set({"n", "x"}, "<leader>nx", function() mc.matchSkipCursor(1) end)
        set({"n", "x"}, "<leader>np", function() mc.matchSkipCursor(-1) end)
        -- Add and remove cursors with control + left click.
        -- set("n", "<c-leftmouse>", mc.handleMouse)
        -- set("n", "<c-leftdrag>", mc.handleMouseDrag)
        -- set("n", "<c-leftrelease>", mc.handleMouseRelease)
        -- Disable and enable cursors.
        -- set({"n", "x"}, "<c-q>", mc.toggleCursor)
        mc.addKeymapLayer(function(layerSet)
            layerSet({"n", "x"}, "<left>", mc.prevCursor)
            layerSet({"n", "x"}, "<right>", mc.nextCursor)
            layerSet({"n", "x"}, "np", mc.deleteCursor)
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}
