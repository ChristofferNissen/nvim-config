-- LSP configs in lsp/
vim.lsp.enable({
    "azure_pipelines_ls",
    "bashls",
    "cssls",
    "docker_compose",
    "dockerls",
    "gh-actions-language-server",
    "gleam",
    "gopls",
    -- "harper-ls",
    "helm-ls",
    "jsonls",
    "luals",
    "marksman",
    "nix",
    "rust_analyzer",
    -- "snyk-ls",
    "terraform-ls",
    "typescript-language-server",
    "yamlls",
    "zls",
})

-- set keymaps for LSP
vim.api.nvim_create_autocmd("LspAttach", {
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
        -- vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        -- vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>a", function()
            require("tiny-code-action").code_action()
        end, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        -- beta
        -- vim.keymap.set('n', '<C-Space>', '<C-x><C-o>', opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set({ "n", "x" }, "gq", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)

        vim.keymap.set("n", "grt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    end,
})

-- Disabled in favor of Conform
-- format on save
-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client == nil then
--             return
--         end
--
--         if client:supports_method("textDocument/formatting") then
--             vim.api.nvim_create_autocmd("BufWritePre", {
--                 buffer = args.buf,
--                 callback = function()
--                     vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
--                 end,
--             })
--         end
--     end,
-- })

-- YamlShowSchema
local function extract_schema_from_hover(text)
    -- Match the first line that starts with one or more '#' and a space, then capture the rest
    local schema = text:match("^#+%s*(.-)\n")
    if schema and #schema > 0 then
        return schema
    end
    return ""
end

vim.api.nvim_create_user_command("YamlShowSchema", function()
    vim.lsp.buf_request(0, "textDocument/hover", {
        textDocument = vim.lsp.util.make_text_document_params(),
        position = { line = 0, character = 0 },
    }, function(_, result)
        if not result or not result.contents then
            vim.notify("No schema found in hover", vim.log.levels.DEBUG)
            return
        end
        local contents = result.contents
        local text = ""
        if type(contents) == "table" then
            if contents.value then
                text = contents.value
            elseif contents[1] then
                text = contents[1].value or contents[1]
            end
        elseif type(contents) == "string" then
            text = contents
        end
        local schema = extract_schema_from_hover(text)
        if schema ~= "" then
            vim.notify("Current YAML schema: " .. schema, vim.log.levels.INFO)
        else
            vim.notify("No schema found in hover", vim.log.levels.WARN)
        end
    end)
end, {})
