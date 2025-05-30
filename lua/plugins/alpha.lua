return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        -- logo font is "Dark with shadow" from <https://texteditor.com/multiline-text-art/>
        local logo = [[
 ██████╗██╗  ██╗██████╗ ██╗███████╗████████╗ ██████╗ ███████╗███████╗███████╗██████╗ ███╗   ██╗██╗███████╗███████╗███████╗███╗   ██╗
██╔════╝██║  ██║██╔══██╗██║██╔════╝╚══██╔══╝██╔═══██╗██╔════╝██╔════╝██╔════╝██╔══██╗████╗  ██║██║██╔════╝██╔════╝██╔════╝████╗  ██║
██║     ███████║██████╔╝██║███████╗   ██║   ██║   ██║█████╗  █████╗  █████╗  ██████╔╝██╔██╗ ██║██║███████╗███████╗█████╗  ██╔██╗ ██║
██║     ██╔══██║██╔══██╗██║╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ██╔══╝  ██╔══██╗██║╚██╗██║██║╚════██║╚════██║██╔══╝  ██║╚██╗██║
╚██████╗██║  ██║██║  ██║██║███████║   ██║   ╚██████╔╝██║     ██║     ███████╗██║  ██║██║ ╚████║██║███████║███████║███████╗██║ ╚████║
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═══╝
      ]]
        dashboard.section.header.val = vim.split(logo, "\n")
        dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Find file", [[:lua require('telescope.builtin').find_files() <cr>]]),
            dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", " " .. " Recent files", [[:lua require('telescope.builtin').oldfiles() <cr>]]),
            dashboard.button("g", " " .. " Find text", [[:lua require('telescope.builtin').live_grep() <cr>]]),
            dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
            dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
            dashboard.button("l", "󰒲 " .. " Lazy", [[:lua vim.cmd("Lazy") <cr>]]),
            dashboard.button("m", "۞" .. " Mason", [[:lua vim.cmd("Mason") <cr>]]),
            dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        }
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.buttons.opts.hl = "AlphaButtons"
        dashboard.section.footer.opts.hl = "AlphaFooter"
        dashboard.opts.layout[1].val = 8
        return dashboard
    end,
    config = function(_, dashboard)
        lazy = require("lazy")
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    lazy.show()
                end,
            })
        end

        require("alpha").setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = lazy.stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
