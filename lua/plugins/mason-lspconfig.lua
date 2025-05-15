return {
    "williamboman/mason-lspconfig.nvim",
    opts = { 
        ensure_installed = { 
            "tflint", 
            "lua_ls", 
            "gopls", 
            "rust_analyzer",
            "terraformls",
            "yamlls",
            "azure_pipelines_ls",

        }
    },
}, 
