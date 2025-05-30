return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
            copilot_model = "gpt-4o-copilot",
            -- suggestion = {
            --     enabled = not vim.g.ai_cmp,
            --     auto_trigger = false,
            --     hide_during_completion = vim.g.ai_cmp,
            --     keymap = {
            --         accept = false, -- handled by nvim-cmp / blink.cmp
            --         next = "<M-]>",
            --         prev = "<M-[>",
            --     },
            -- },
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
        build = "make tiktoken",                   -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
