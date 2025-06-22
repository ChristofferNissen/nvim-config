vim.opt.guicursor = ""

vim.opt.nu = true

vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.cindent = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.listchars:append("space:.")
vim.opt.listchars:append("eol:󱞣")
vim.o.timeout = true
vim.o.timeoutlen = 1000

-- folding https://www.jmaguire.tech/posts/treesitter_folding/
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- custom filetypes
vim.filetype.add({
    pattern = {
        ["release%-pipelines?%.ya?ml"] = "azure-pipelines",
        ["azure%-pipelines?%.ya?ml"] = "azure-pipelines",
        [".azure%-pipelines/.*%.ya?ml"] = "azure-pipelines",
    },
})
vim.treesitter.language.register("yaml", "azure-pipelines")

-- vim.api.nvim_create_autocmd("BufReadPost", {
--     pattern = { "azure-pipelines.yaml", "azure-pipelines.yml", "*.azure-pipelines/*.yml", "*.azure-pipelines/*.yaml" },
--     callback = function()
--         vim.bo.filetype = "azure-pipelines"
--         vim.lsp.start({
--             name = "azure-pipelines-ls",
--             cmd = { "azure-pipelines-language-server", "--stdio" },
--             filetypes = { "azure-pipelines" },
--             root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
--         })
--     end,
-- })
