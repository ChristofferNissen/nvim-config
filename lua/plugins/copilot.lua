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
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
            system_prompt = vim.fn.fnamemodify(vim.env.MYVIMRC, ":h") .. "/lua/plugins/prompts/4.1.chatmode.md",
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
