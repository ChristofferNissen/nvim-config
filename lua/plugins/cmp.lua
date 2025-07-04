return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                config = function()
                    -- Load collection
                    require("luasnip.loaders.from_vscode").lazy_load()
                    -- Add custom snippets
                    require("luasnip.loaders.from_vscode").lazy_load({
                        paths = { vim.fn.stdpath("config") .. "/snippets" },
                    })
                    require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
                end,
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
            },
            "fang2hou/blink-copilot",
            -- "Kaiser-Yang/blink-cmp-avante",
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

            enabled = function()
                return not vim.list_contains({ "lazy", "typr" }, vim.bo.filetype)
                    and vim.bo.buftype ~= "prompt"
                    and vim.b.completion ~= false
            end,

            completion = { documentation = { auto_show = false } },

            snippets = { preset = "luasnip" },

            sources = {
                default = { "codecompanion", "copilot", "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    -- avante = {
                    --     module = "blink-cmp-avante",
                    --     name = "Avante",
                    --     opts = {
                    --         -- options for blink-cmp-avante
                    --     },
                    -- },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 90,
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
