-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- General settings
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.guicursor = ""

-- Setup lazy.nvim
require("lazy").setup("plugins", {
    rocks = { enabled = false },
    dev = {
        path = "~/.local/share/nvim/nix",
        fallback = false,
    },
})

-- Load Personal Config
require("ChristofferNissen")
-- vim.cmd [[colorscheme tokyonight-storm]]
vim.cmd([[colorscheme catppuccin-mocha]])

-- Configure diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = "rounded",
        -- source = "always",
    },
})
