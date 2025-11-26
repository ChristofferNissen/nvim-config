-- LSP configs in lsp/
vim.lsp.enable({
    "azure_pipelines_ls",
    "bashls",
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    "gh_actions_ls",
    "gleam",
    "gopls",
    "harper-ls",
    "helm-ls",
    "jsonls",
    "kotlin-lsp",
    "luals",
    "marksman",
    "nix",
    "rust_analyzer",
    "sqlls",
    "templ",
    "terraform-ls",
    "typescript-language-server",
    "yamlls",
    "zls",
})

-- set keymaps for LSP
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }

        -- CUSTOM
        vim.keymap.set("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)

        -- GLOBAL
        vim.keymap.set("n", "grn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set("n", "gra", function()
            require("tiny-code-action").code_action()
        end, { noremap = true, silent = true })
        vim.keymap.set("n", "grr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "gri", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "grt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gO", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)
        vim.keymap.set("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

        -- BUFFER-LOCAL
        -- vim.keymap.set("n", "<C-Space>", "<C-x><C-o>", opts)
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set({ "n", "x" }, "gq", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)

        -- DIAGNOSTICS
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.get_prev({ float = true })
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.get_next({ float = true })
        end, opts)
    end,
})

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
