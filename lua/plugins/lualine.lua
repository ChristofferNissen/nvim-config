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
local job_indicator = { require("easy-dotnet.ui-modules.jobs").lualine }

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            { "echasnovski/mini.icons", optional = true },
            { "AndreM222/copilot-lualine" },
        },
        opts = {
            options = {
                theme = "auto",
                -- theme = "dracula",
                -- theme = "catppuccin-mocha",
                icons_enabled = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode", job_indicator },
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
        },
    },
}
