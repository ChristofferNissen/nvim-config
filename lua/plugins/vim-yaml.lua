return {
    {
        "stephpy/vim-yaml",
        lazy = false,                 -- load on startup; set to true if you want lazy loading
        ft = { "yaml", "azure_pipelines" }, -- filetypes to load this plugin for
        config = function(opts)
            require("yaml_nvim").setup(opts)
        end,
        opts = {
            ft = { "yaml", "azure_pipelines" },
        },
    },
}
