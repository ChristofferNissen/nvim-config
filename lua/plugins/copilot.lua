return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        dependencies = {
            "copilotlsp-nvim/copilot-lsp",
        },
        opts = {
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
}
