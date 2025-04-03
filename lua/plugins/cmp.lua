return {
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = {
            'rafamadriz/friendly-snippets',
            'fang2hou/blink-copilot',
            -- {
            --     "supermaven-inc/supermaven-nvim",
            --     opts = {
            --         disable_inline_completion = true, -- disables inline completion for use with cmp
            --         disable_keymaps = true -- disables built in keymaps for more manual control
            --     }
            -- },
            -- 'huijiro/blink-cmp-supermaven'
        },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', }, -- "supermaven"
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                    -- supermaven = {
                    --     name = 'supermaven',
                    --     module = "blink-cmp-supermaven",
                    --     async = true
                    -- }
                },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    -- {
    --     "neovim/nvim-lspconfig",
    --     event = { "BufReadPre", "BufNewFile" },
    --     dependencies = {
    --         {
    --             "williamboman/mason.nvim",
    --             opts = { ensure_installed = { "goimports", "gofumpt", "gomodifytags", "impl", "delve" } },
    --         },
    --         {
    --             "williamboman/mason-lspconfig.nvim",
    --             opts = { ensure_installed = { "tflint", "lua_ls", "gopls", "rust_analyzer", "terraformls", "yamlls" } },
    --         },
    --         {
    --             "VonHeikemen/lsp-zero.nvim",
    --             branch = "v4.x",
    --             lazy = true,
    --             config = false,
    --         },
    --         { "nvim-treesitter/nvim-treesitter" },
    --     },
    --     config = function()
    --         local lsp = require("lsp-zero")
    --         local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --         parser_config.nu = {
    --             install_info = {
    --                 url = "https://github.com/nushell/tree-sitter-nu",
    --                 files = { "src/parser.c" },
    --                 branch = "main",
    --             },
    --             filetype = "nu",
    --         }
    --
    --         local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
    --         vim.api.nvim_create_autocmd("BufWritePre", {
    --             pattern = "*",
    --             callback = function()
    --                 vim.lsp.buf.format({ timeout_ms = 200 })
    --             end,
    --             group = format_sync_grp,
    --         })
    --
    --         local lsp_attach = function(client, bufnr)
    --             local opts = { buffer = bufnr, remap = false }
    --             vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    --             vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    --             vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    --             vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    --             vim.keymap.set("n", "[d", function()
    --                 vim.diagnostic.jump({ count = -1, float = true })
    --             end, opts)
    --             vim.keymap.set("n", "]d", function()
    --                 vim.diagnostic.jump({ count = 1, float = true })
    --             end, opts)
    --             vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    --             vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    --             vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    --             vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    --             vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    --             client.server_capabilities.semanticTokensProvider = nil
    --         end
    --
    --         vim.diagnostic.config({
    --             virtual_text = true,
    --             signs = true,
    --             update_in_insert = true,
    --             underline = true,
    --             severity_sort = false,
    --             float = true,
    --         })
    --
    --         lsp.extend_lspconfig({
    --             capabilities = require("cmp_nvim_lsp").default_capabilities(),
    --             lsp_attach = lsp_attach,
    --             float_border = "rounded",
    --             sign_text = true,
    --             set_lsp_keymaps = { preserve_mappings = false },
    --         })
    --
    --         local lspconfig = require("lspconfig")
    --     end,
    -- },
}
