vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true, timeout_ms = 10000 })
end)
vim.keymap.set("n", "<leader>ll", function()
    require("lint").try_lint()
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>q", ":copen<CR>", { noremap = true, silent = true })

-- tiny code action
vim.keymap.set({ "n", "x" }, "<leader>ca", function()
    require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

-- terraform doc
vim.api.nvim_set_keymap("n", "<leader>ptd", ":OpenDoc<CR>", { noremap = true, silent = true })

-- Bufferline replacement
vim.keymap.set("n", "H", ":bprev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "L", ":bnext<CR>", { noremap = true, silent = true })

-- persistence
-- load the session for the current directory
vim.keymap.set("n", "<leader>bs", function()
    require("persistence").load()
end, { desc = "Load current session" })

-- select a session to load
vim.keymap.set("n", "<leader>bS", function()
    require("persistence").select()
end, { desc = "Select session to load" })

-- load the last session
vim.keymap.set("n", "<leader>bl", function()
    require("persistence").load({ last = true })
end, { desc = "Load last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>bd", function()
    require("persistence").stop()
end, { desc = "Stop Persistence" })
