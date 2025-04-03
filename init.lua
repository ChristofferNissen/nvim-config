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
vim.loader.enable(true)
require("ChristofferNissen")
vim.lsp.enable({ 'gopls', 'luals', 'terraform-ls', 'yamlls', 'rust_analyzer', 'marksman', 'gleam', 'dockerls',
    'docker_compose', 'nix' })

-- https://gpanders.com/blog/whats-new-in-neovim-0-11/
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
