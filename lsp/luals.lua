---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "require" },
                disable = { "lowercase-global" },
            },
            runtime = {
                version = "LuaJIT",
            },
            codeLens = {
                enable = true,
            },
            completion = {
                callSnippet = "Replace",
            },
            doc = {
                privateName = { "^_" },
            },
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
            },
            workspace = {
                checkThirdParty = false,
                -- Make the server aware of Neovim runtime files
                -- library = vim.api.nvim_get_runtime_file("", true),
                library = vim.tbl_extend(
                    "keep",
                    { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
                    vim.api.nvim_get_runtime_file("", true)
                ),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                    quote_style = "auto",
                    line_width = "120",
                    column_limit = "120",
                    tab_width = "2",
                    insert_final_newline = true,
                    trim_trailing_whitespace = true,
                },
            },
        },
    },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", "luarc.lua", ".git" },
}
