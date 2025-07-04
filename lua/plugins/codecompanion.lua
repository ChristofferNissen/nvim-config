return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim",
        },
        config = function()
            require("codecompanion").setup({
                -- Example: set the default chat adapter to Copilot (requires copilot.vim and setup)
                strategies = {
                    chat = {
                        adapter = "copilot",
                    },
                },

                system_prompt = function(opts)
                    local http = require("socket.http")
                    local url =
                        "https://gist.githubusercontent.com/ChristofferNissen/a64f508def50801550cbfe4922d92b40/raw/6e497f4b4ef5e7ea36787ef38fdf4385433591c1/4.1.chatmode.md"
                    local body, code = http.request(url)
                    if code == 200 and body then
                        print(body)
                        return body
                    else
                        print("Failed to fetch system prompt")
                        return ""
                    end
                end,

                extensions = {
                    mcphub = {
                        callback = "mcphub.extensions.codecompanion",
                        opts = {
                            make_vars = true,
                            make_slash_commands = true,
                            show_result_in_chat = true,
                        },
                    },
                },
            })
        end,
    },
}
