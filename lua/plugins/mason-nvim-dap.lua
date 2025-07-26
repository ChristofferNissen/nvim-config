return {
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        },
        cmd = { "DapInstall", "DapUninstall" },
        ---@type MasonNvimDapSettings
        opts = {
            -- This line is essential to making automatic installation work
            -- :exploding-brain
            handlers = {},
            automatic_installation = {
                enable = true,
                -- These will be configured by separate plugins.
                exclude = {
                    "delve",
                    "python",
                },
            },
            -- DAP servers: Mason will be invoked to install these if necessary.
            ensure_installed = {
                "bash",
                "codelldb",
                "php",
                "python",
            },
        },
    },
}
