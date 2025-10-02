-- ================================================================================================
-- TITLE: NeoVim keymaps
-- ABOUT: sets some quality-of-life keymaps
-- ================================================================================================

vim.keymap.set("n", "<leader>g", "G", { desc = "G" })
vim.keymap.set("n", "<leader>v", "V", { desc = "V" })

vim.keymap.set("v", "yc", '"+y', { desc = "Copy to ClipBoard" })
vim.keymap.set("n", "yp", '"+p', { desc = "Paste from ClipBoard" })

vim.keymap.set("n", "<A-u>", "<C-d>", { desc = "Page down (centered)" })
vim.keymap.set("n", "<A-i>", "<C-u>", { desc = "Page down (centered)" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", "<Cmd>e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- File Explorer
-- vim.keymap.set("n", "<leader>m", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus on File Explorer" })
vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

vim.keymap.set("n", "<leader>m", function()
    local api = require("nvim-tree.api")
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "NvimTree" then
        vim.cmd("wincmd p")
    else
        api.tree.focus()
    end
end, { desc = "Toggle focus between editor and NvimTree" })

vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "close file" })
vim.keymap.set("n", "<leader>i", "gg=G``zz", { desc = "Indent file" })

vim.keymap.set("v", "<leader>so", ":sort<CR>", { desc = "Sort selected lines" })

vim.keymap.set("n", "<leader>k", ":FzfLua keymaps<CR>", { desc = "Fzf Keymaps" })

vim.keymap.set("n", "<S-u>", "<C-R>", { desc = "Redo" })

vim.keymap.set("n", "<leader>h", "<Cmd>nohlsearch<CR>", { desc = "Toggle search highlight" })

vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<CR>", {desc = "Noice Last Message" })
vim.keymap.set("n", "<leader>nh", "<cmd>Noice history<CR>", {desc = "Noice History" })
vim.keymap.set("n", "<leader>nf", "<cmd>Noice fzf<CR>", {desc = "Noice Fzf" })
vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<CR>", {desc = "Noice Dismiss" })
vim.keymap.set("n", "<leader>nc", "<cmd>Noice cmdline<CR>", {desc = "Noice Commandline" })

-- Map <leader>fp to open projects
vim.keymap.set('n', '<leader>fp', ':ProjectFzf<CR>', { noremap = true, silent = true })

-- Toggle maximize current split with <C-m>
vim.keymap.set("n", "<C-m>", function()
    if vim.t.maximized then
        -- restore previous view
        vim.cmd(vim.t.maximized_cmd)
        vim.t.maximized = false
    else
        -- save current layout
        vim.t.maximized_cmd = vim.fn.winrestcmd()
        vim.cmd("wincmd |")
        vim.cmd("wincmd _")
        vim.t.maximized = true
    end
end, { desc = "Toggle maximize current split" })

