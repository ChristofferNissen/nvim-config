---@type vim.lsp.Config
return {
    cmd = { "hyprls" },
    filetypes = { "hyprlang" },
    root_dir = vim.fn.getcwd(),
    settings = {
        hyprls = {
            preferIgnoreFile = true, -- set to false to prefer `hyprls.ignore`
            ignore = { "hyprlock.conf", "hypridle.conf" },
        },
    }, -- add custom settings here if needed
}
