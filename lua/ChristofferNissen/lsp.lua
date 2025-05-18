-- LSP configs in lsp/
vim.lsp.enable(
    {
        'azure-pipelines-ls',
        'bashls', 
        'gopls',
        'luals',
        'terraform-ls',
        'yamlls',
        'rust_analyzer',
        'marksman',
        'gleam',
        'dockerls',
        'docker_compose',
        'nix',
        "omnisharp",
        "zls",
        "cssls",
    }
)

-- set keymaps for LSP
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }

        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.get_prev({ float = true })
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.get_next({ float = true })
        end, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        -- beta
        -- vim.keymap.set('n', '<C-Space>', '<C-x><C-o>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

        vim.keymap.set('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    end,
})

-- format on save
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end
    end,
})

-- enable completion triggered by <C-Space>
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
--     end
--   end,
-- })

-- example of global config
-- vim.lsp.config('*', {
--     on_init = function()
--         print('this will be everywhere')
--     end,
-- })

-- example of ls specitic config
-- vim.lsp.config('luals', {
--     on_attach = function()
--         print('luals is now active in this file')
--     end,
-- })

-- https://lsp-zero.netlify.app/blog/lsp-client-features.html
