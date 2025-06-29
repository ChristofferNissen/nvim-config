---@type vim.lsp.Config
return {
    cmd = { "templ", "lsp" },
    filetypes = { "templ" },
    root_dir = function(fname)
        return util.root_pattern("go.work", "go.mod", ".git")(fname)
    end,
}
