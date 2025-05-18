go_package = function()
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, true)) do
        if line:match("^package ") then
            return "⬡ " .. string.sub(line, 9)
        end
    end
    return ""
end

-- Autocommand to update schema info for YAML files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    pattern = { "*.yaml", "*.yml" },
    callback = function(args)
        local bufnr = args.buf
        local filetype = vim.bo[bufnr].filetype
        if filetype ~= "yaml" and filetype ~= "yml" then
            return
        end

        -- Only run if an LSP client is attached
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if #clients == 0 then
            vim.b[bufnr].yaml_schema_lualine = "lsp not started"
            return
        end

        -- Request hover info at the first character
        vim.lsp.buf_request(bufnr, "textDocument/hover", {
            textDocument = vim.lsp.util.make_text_document_params(bufnr),
            position = { line = 0, character = 0 },
        }, function(_, result)
            if not result or not result.contents then
                vim.b[bufnr].yaml_schema_lualine = ""
                return
            end

            -- Parse result to extract schema info (customize as needed)
            local contents = result.contents
            local text = ""
            if type(contents) == "table" then
                if contents.value then
                    text = contents.value
                elseif contents[1] then
                    text = contents[1].value or contents[1]
                end
            elseif type(contents) == "string" then
                text = contents
            end

            local name = text:match("%s*#+%s*([^\n]+)")
            if not name then
                name = text
            end
            -- vim.notify("Name: " .. name)
            vim.b[bufnr].yaml_schema_lualine = name or ""

            -- Try to extract a schema URL or give a preview
            -- local schema = text:match("https?://%S+%.json")
            -- if not schema then
            --     schema = text:sub(1, 40)
            -- end
            -- vim.b[bufnr].yaml_schema_lualine = schema or ""
        end)
    end,
})

-- Lualine component
local function yaml_schema_component()
    return vim.b.yaml_schema_lualine or ""
end

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons", optional = true },
        opts = {
            options = {
                theme = "dracula",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    {
                        go_package,
                        cond = function()
                            return vim.bo.filetype == "go"
                        end,
                    },
                    { "filename" },
                },
                lualine_x = {
                    { yaml_schema_component },
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
    },
}
