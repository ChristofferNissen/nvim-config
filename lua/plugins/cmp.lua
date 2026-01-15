return {
    {
        "saghen/blink.cmp",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                config = function()
                    -- Load std collection
                    require("luasnip.loaders.from_vscode").lazy_load()
                    -- Add custom snippets
                    require("luasnip.loaders.from_vscode").lazy_load({
                        paths = { vim.fn.stdpath("config") .. "/snippets" },
                    })
                    require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
                end,
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    {
                        "saghen/blink.compat",
                        optional = true,
                        opts = {},
                        version = not vim.g.lazyvim_blink_main and "*",
                    },
                },
            },
            "fang2hou/blink-copilot",
            {
                "catppuccin",
                optional = true,
                opts = {
                    integrations = { blink_cmp = true },
                },
            },
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
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                documentation = { auto_show = true, auto_show_delay_ms = 200 },
                ghost_text = { enabled = vim.g.ai_cmp },
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = { "copilot", "easy-dotnet", "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                    -- charp = {inherit_defaults = true, "easy-dotnet"
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    ["easy-dotnet"] = {
                        name = "easy-dotnet",
                        enabled = true,
                        module = "easy-dotnet.completion.blink",
                        score_offset = 10000,
                        async = true,
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
