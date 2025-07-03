return {
    {
        "yetone/avante.nvim",
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        -- ⚠️ must add this setting! ! !
        build = function()
            -- conditionally use the correct build system for the current OS
            if vim.fn.has("win32") == 1 then
                return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            else
                return "make"
            end
        end,
        -- event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            provider = "copilot", -- Use Copilot as the provider
            -- You can add other options here as needed
            -- auto_suggestions_provider = "copilot",
            -- behaviour = {
            --     auto_suggestions = true,
            -- },
            -- system_prompt = "https://gist.github.com/ChristofferNissen/a64f508def50801550cbfe4922d92b40",
            system_prompt = function()
                return vim.fn.stdpath("config") .. "/lua/plugins/avante_prompts/4.1.chatmode.md"
            end,
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
    },
}
