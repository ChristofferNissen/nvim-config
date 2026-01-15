local schemastore_schemas = require("schemastore").yaml.schemas({
    select = {
        "Azure Pipelines",
    },
})

--@type vim.lsp.Config
return {
    cmd = { "azure-pipelines-language-server", "--stdio" },
    filetypes = { "azure_pipelines" },
    single_file_support = true,
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
        },
    },
    settings = {
        yaml = {
            -- keyOrdering = false,
            -- format = {
            --     enable = true,
            -- },
            completions = true,
            validate = true,
            redhat = { telemetry = { enabled = false } },
            -- schemas = schemastore_schemas,
            schemas = {
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                    "*",
                },
            },
            schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
        },
    },
    root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
    root_markers = { "azure-pipelines.yml" },
}
