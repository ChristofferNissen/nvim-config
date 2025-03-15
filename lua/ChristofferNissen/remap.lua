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
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- terraform doc
vim.api.nvim_set_keymap("n", "<leader>do", ":OpenDoc<CR>", { noremap = true, silent = true })

-- Key mappings Colemak Dh
vim.api.nvim_set_keymap("n", "d", "g", { noremap = true })
vim.api.nvim_set_keymap("n", "e", "k", { noremap = true })
vim.api.nvim_set_keymap("n", "f", "e", { noremap = true })
vim.api.nvim_set_keymap("n", "g", "t", { noremap = true })
vim.api.nvim_set_keymap("n", "i", "l", { noremap = true })
vim.api.nvim_set_keymap("n", "j", "y", { noremap = true })
vim.api.nvim_set_keymap("n", "k", "n", { noremap = true })
vim.api.nvim_set_keymap("n", "l", "u", { noremap = true })
vim.api.nvim_set_keymap("n", "n", "j", { noremap = true })
vim.api.nvim_set_keymap("n", "o", "p", { noremap = true })
vim.api.nvim_set_keymap("n", "p", "r", { noremap = true })
vim.api.nvim_set_keymap("n", "r", "s", { noremap = true })
vim.api.nvim_set_keymap("n", "s", "d", { noremap = true })
vim.api.nvim_set_keymap("n", "t", "f", { noremap = true })
vim.api.nvim_set_keymap("n", "u", "i", { noremap = true })
vim.api.nvim_set_keymap("n", "y", "o", { noremap = true })
vim.api.nvim_set_keymap("n", "D", "G", { noremap = true })
vim.api.nvim_set_keymap("n", "E", "K", { noremap = true })
vim.api.nvim_set_keymap("n", "F", "E", { noremap = true })
vim.api.nvim_set_keymap("n", "G", "T", { noremap = true })
vim.api.nvim_set_keymap("n", "I", "L", { noremap = true })
vim.api.nvim_set_keymap("n", "J", "Y", { noremap = true })
vim.api.nvim_set_keymap("n", "K", "N", { noremap = true })
vim.api.nvim_set_keymap("n", "L", "U", { noremap = true })
vim.api.nvim_set_keymap("n", "N", "J", { noremap = true })
vim.api.nvim_set_keymap("n", "O", "P", { noremap = true })
vim.api.nvim_set_keymap("n", "P", "R", { noremap = true })
vim.api.nvim_set_keymap("n", "R", "S", { noremap = true })
vim.api.nvim_set_keymap("n", "S", "D", { noremap = true })
vim.api.nvim_set_keymap("n", "T", "F", { noremap = true })
vim.api.nvim_set_keymap("n", "U", "I", { noremap = true })
vim.api.nvim_set_keymap("n", "Y", "O", { noremap = true })
