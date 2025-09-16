return {
    {
        "RRethy/vim-illuminate",
        config = function()
            -- Optional: your configuration for vim-illuminate can go here
            vim.g.Illuminate_delay = 100
        end,
        event = "VeryLazy", -- Load on a lazy event, or you can use "BufReadPost" etc.
    },
    {
        "hedyhli/outline.nvim",
        config = function()
            -- Example mapping to toggle outline
            vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
            require("outline").setup({
                -- Your setup opts here (leave empty to use defaults)
            })
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function(opts)
            require("tokyonight").setup(opts)
            vim.cmd([[colorscheme tokyonight-storm]])
        end,
        opts = {
            style = "storm",
        },
    },
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            -- { "nvim-telescope/telescope.nvim" },
        },
        event = "LspAttach",
        opts = {
            picker = {
                "buffer",
                opts = {
                    hotkeys = true,
                    hotkeys_mode = "text_diff_based",
                },
            },
        },
    },
    {
        "folke/trouble.nvim",
        opts = {
            modes = {
                test = {
                    mode = "diagnostics",
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.3,
                    },
                },
            },
        }, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        tag = "v1.0.0",
        event = { "BufReadPost" },
        opts = {},
    },
    {
        "b0o/incline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- For file type icons
            "lewis6991/gitsigns.nvim", -- For Git integration
        },
        config = function()
            local devicons = require("nvim-web-devicons")
            require("incline").setup({
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if filename == "" then
                        filename = "[No Name]"
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)

                    local function get_git_diff()
                        local icons = { removed = "", changed = "", added = "" }
                        local signs = vim.b[props.buf].gitsigns_status_dict
                        local labels = {}
                        if signs == nil then
                            return labels
                        end
                        for name, icon in pairs(icons) do
                            if tonumber(signs[name]) and signs[name] > 0 then
                                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
                            end
                        end
                        if #labels > 0 then
                            table.insert(labels, { "┊ " })
                        end
                        return labels
                    end

                    local function get_diagnostic_label()
                        local icons = { error = "", warn = "", info = "", hint = "" }
                        local label = {}

                        for severity, icon in pairs(icons) do
                            local n = #vim.diagnostic.get(
                                props.buf,
                                { severity = vim.diagnostic.severity[string.upper(severity)] }
                            )
                            if n > 0 then
                                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
                            end
                        end
                        if #label > 0 then
                            table.insert(label, { "┊ " })
                        end
                        return label
                    end

                    return {
                        { get_diagnostic_label() },
                        { get_git_diff() },
                        { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
                        { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
                        { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
                    }
                end,
            })
        end,
        -- Optional: Lazy load Incline
        event = "VeryLazy",
    },
    {
        "luukvbaal/statuscol.nvim",
        event = "VeryLazy",
        opts = {
            setopt = true,
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
            -- add any options here
        },
    },
    {
        "f-person/git-blame.nvim",
        -- load the plugin at startup
        event = "VeryLazy",
        -- Because of the keys part, you will be lazy loading this plugin.
        -- The plugin will only load once one of the keys is used.
        -- If you want to load the plugin at startup, add something like event = "VeryLazy",
        -- or lazy = false. One of both options will work.
        opts = {
            -- your configuration comes here
            -- for example
            enabled = true, -- if you want to enable the plugin
            message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
            date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
            virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            { "echasnovski/mini.icons", optional = true },
            { "AndreM222/copilot-lualine" },
        },
        config = function()
            go_package = function()
                for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, true)) do
                    if line:match("^package ") then
                        return "⬡ " .. string.sub(line, 9)
                    end
                end
                return ""
            end

            -- Cache table for storing schema per buffer
            local yaml_schema_cache = {}

            -- Function to asynchronously update YAML schema (with delay)
            local function update_yaml_schema(bufnr)
                vim.defer_fn(function()
                    -- Only run if an LSP client is attached
                    local clients = vim.lsp.get_clients({ bufnr = bufnr })
                    if #clients == 0 then
                        yaml_schema_cache[bufnr] = "lsp not started"
                        vim.b[bufnr].yaml_schema_lualine = "lsp not started"
                        return
                    end

                    -- Request hover info at the first character
                    vim.lsp.buf_request(bufnr, "textDocument/hover", {
                        textDocument = vim.lsp.util.make_text_document_params(bufnr),
                        position = { line = 0, character = 0 },
                    }, function(_, result)
                        local text = ""
                        if result and result.contents then
                            local contents = result.contents
                            if type(contents) == "table" then
                                if contents.value then
                                    text = contents.value
                                elseif contents[1] then
                                    text = contents[1].value or contents[1]
                                end
                            elseif type(contents) == "string" then
                                text = contents
                            end
                        end

                        local name = text:match("%s*#+%s*([^\n]+)") or text or ""
                        yaml_schema_cache[bufnr] = name
                        vim.b[bufnr].yaml_schema_lualine = name

                        -- Optionally force statusline redraw
                        vim.cmd("redrawstatus")
                    end)
                end, 1000) -- Delay (ms)
            end

            -- Autocommand to update schema info for YAML files
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
                pattern = { "*.yaml", "*.yml" },
                callback = function(args)
                    local bufnr = args.buf
                    local filetype = vim.bo[bufnr].filetype
                    -- vim.notify("Updating YAML schema for " .. vim.fn.expand("%:t"), vim.log.levels.INFO, { title = "LSP" })
                    if filetype ~= "yaml" and filetype ~= "yml" then
                        return
                    end
                    update_yaml_schema(bufnr)
                end,
            })

            -- Lualine component
            local function yaml_schema_component()
                local bufnr = vim.api.nvim_get_current_buf()
                return yaml_schema_cache[bufnr] or ""
            end

            vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
            local git_blame = require("gitblame")

            opts = {
                options = {
                    theme = "dracula",
                    -- theme = "catppuccin-mocha",
                    icons_enabled = true,
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        "branch",
                        "diff",
                        -- "diagnostics",
                        {
                            "diagnostics",
                            sources = {
                                --"nvim_lsp",
                                --"nvim_diagnostic",
                                "nvim_workspace_diagnostic",
                            },
                        },
                    },
                    lualine_c = {
                        {
                            go_package,
                            cond = function()
                                return vim.bo.filetype == "go"
                            end,
                        },
                        { "filename" },
                        { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
                    },

                    lualine_x = {
                        { yaml_schema_component },
                        "copilot",
                    },
                    lualine_y = {
                        "encoding",
                        "fileformat",
                        "filetype",
                    },
                    lualine_z = { "progress", "location" },
                },
            }
            require("lualine").setup(opts)
        end,
    },
}
