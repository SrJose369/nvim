local M = {}

M.on_attach = function(client, bufnr)
    local keymap = vim.keymap.set
    local opts = {
        noremap = true, -- prevent recursive mapping
        silent = true, -- don't print the command to the cli
        buffer = bufnr, -- restrict the keymap to the local buffer number
    }

    -- Map <leader>f to format the current buffer
    vim.keymap.set('n', '<leader>p', function()
        vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = 'LSP Format File' })

    -- native neovim keymaps
    vim.keymap.set("n", "<leader>gs", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts) -- goto definition in split

    -- fzf-lua keymaps
    vim.keymap.set("n", "<leader>gd", "<cmd>FzfLua lsp_finder<CR>", opts) -- LSP Finder (definition + references)
    vim.keymap.set("n", "<leader>gr", "<cmd>FzfLua lsp_references<CR>", opts) -- Show all references to the symbol under the cursor
    vim.keymap.set("n", "<leader>gt", "<cmd>FzfLua lsp_typedefs<CR>", opts) -- Jump to the type definition of the symbol under the cursor
    vim.keymap.set("n", "<leader>ds", "<cmd>FzfLua lsp_document_symbols<CR>", opts) -- List all symbols (functions, classes, etc.) in the current file
    vim.keymap.set("n", "<leader>ws", "<cmd>FzfLua lsp_workspace_symbols<CR>", opts) -- Search for any symbol across the entire project/workspace
    vim.keymap.set("n", "<leader>gi", "<cmd>FzfLua lsp_implementations<CR>", opts) -- Go to implementation

    local opts2= {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts2)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts2)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts2)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts2)
    vim.keymap.set("n", "gn", function() vim.diagnostic.goto_next() end, opts2)
    vim.keymap.set("n", "gp", function() vim.diagnostic.goto_prev() end, opts2)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts2)
    vim.keymap.set("n", "gu", function() vim.lsp.buf.references() end, opts2)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts2)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts2)
    vim.keymap.set("n", "ge", function() vim.diagnostic.open_float({ scope = 'line' }) end, opts) -- Line diagnostics (float)
    vim.keymap.set("n", "<leader>D", function() vim.diagnostic.open_float() end, opts) -- Cursor diagnostics

    -- Order Imports (if supported by the client LSP)
    if client.supports_method("textDocument/codeAction") then
        keymap("n", "<leader>oi", function()
            vim.lsp.buf.code_action({
                context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                },
                apply = true,
                bufnr = bufnr,
            })
            -- format after changing import order
            vim.defer_fn(function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end, 50) -- slight delay to allow for the import order to go first
        end, opts)
    end

    -- === DAP keymaps ===
    if client.name == "rust-analyzer" then -- debugging only configured for Rust
        local dap = require("dap")
        keymap("n", "<leader>dc", dap.continue, opts) -- Continue / Start
        keymap("n", "<leader>do", dap.step_over, opts) -- Step over
        keymap("n", "<leader>di", dap.step_into, opts) -- Step into
        keymap("n", "<leader>du", dap.step_out, opts) -- Step out
        keymap("n", "<leader>db", dap.toggle_breakpoint, opts) -- Toggle breakpoint
        keymap("n", "<leader>dr", dap.repl.open, opts) -- Open DAP REPL
    end
end

return M
