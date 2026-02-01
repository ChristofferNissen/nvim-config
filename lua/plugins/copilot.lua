return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
            -- copilot_model = "gpt-4o-copilot",
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    }
}
