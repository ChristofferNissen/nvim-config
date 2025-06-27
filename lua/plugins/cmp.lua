return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load({
                        paths = { vim.fn.stdpath("config") .. "/snippets" },
                    })
                    require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
                end,
            },
            "rafamadriz/friendly-snippets",
            "fang2hou/blink-copilot",
        },

        -- use a release tag to download pre-built binaries
        version = "1.*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "default" },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = { documentation = { auto_show = false } },

            snippets = { preset = "luasnip" },

            sources = {
                default = { "lsp", "copilot", "path", "snippets", "buffer" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },

            signature = {
                enabled = true,
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },
}
