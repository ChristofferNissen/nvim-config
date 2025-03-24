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

-- Function to toggle Oil file explorer
-- function ToggleOil()
--     local bufname = vim.api.nvim_buf_get_name(0)
--     if bufname:match("^oil://") then
--         vim.cmd('bd')  -- close the buffer if it's an Oil buffer
--     else
--         vim.cmd('Oil') -- open Oil file explorer
--     end
-- end

-- function CloseOil()
--     local bufname = vim.api.nvim_buf_get_name(0)
--     if bufname:match("^oil://") then
--         vim.cmd('bd') -- close the buffer if it's an Oil buffer
--     end
-- end

-- Keybinding for Oil file explorer
-- vim.api.nvim_set_keymap('n', '<leader>e', ':lua ToggleOil()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>q', ':lua CloseOil()<CR>', { noremap = true, silent = true })

-- Keybinding to open Oil file explorer
vim.api.nvim_set_keymap('n', '<leader>e', ':Oil<CR>', { noremap = true, silent = true })
