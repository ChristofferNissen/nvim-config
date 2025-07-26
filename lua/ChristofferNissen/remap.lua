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

-- terraform doc
vim.api.nvim_set_keymap("n", "<leader>ptd", ":OpenDoc<CR>", { noremap = true, silent = true })

-- inc-rename
vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- Bufferline replacement
vim.keymap.set("n", "H", ":bprev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "L", ":bnext<CR>", { noremap = true, silent = true })

-- copilot chat
vim.keymap.set("n", "<leader>cct", function()
    require("CopilotChat").toggle()
end, { desc = "CopilotChat - Toggle chat" })

vim.keymap.set("n", "<leader>cca", function()
    require("CopilotChat").stop()
end, { desc = "CopilotChat - Stop" })

-- Quick chat keybinding
vim.keymap.set("n", "<leader>ccq", function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
        require("CopilotChat").ask(input, {
            selection = require("CopilotChat.select").buffer,
        })
    end
end, { desc = "CopilotChat - Quick chat" })

-- Copilot Chat History
local function list_and_load_file()
    -- Get directory from user (or use current directory)
    -- local dir = vim.fn.input("Directory: ", vim.fn.getcwd(), "dir")
    local dir = vim.fn.stdpath("data") .. "/copilotchat_history"
    -- List files in directory
    local files = vim.fn.readdir(dir)
    if not files or vim.tbl_isempty(files) then
        vim.notify("No files found in " .. dir, vim.log.levels.WARN)
        return
    end
    -- Select file
    vim.ui.select(files, { prompt = "Select a file to load to CopilotChat:" }, function(choice)
        if choice then
            local name = choice:gsub("%.json$", "")
            require("CopilotChat").load(name, dir)
            vim.notify("Loaded " .. name .. " to CopilotChat")
        end
    end)
end
vim.keymap.set("n", "<leader>cch", function()
    list_and_load_file()
end, { desc = "CopilotChat - Chat History" })

vim.keymap.set("n", "<leader>ccs", function()
    local name = vim.fn.input("Save CopilotChat chat as: ")
    require("CopilotChat").save(name)
end, { desc = "CopilotChat - Save file" })

-- persistence
-- load the session for the current directory
vim.keymap.set("n", "<leader>gs", function()
    require("persistence").load()
end, { desc = "Load current session" })

-- select a session to load
vim.keymap.set("n", "<leader>gS", function()
    require("persistence").select()
end, { desc = "Select session to load" })

-- load the last session
vim.keymap.set("n", "<leader>gl", function()
    require("persistence").load({ last = true })
end, { desc = "Load last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>gd", function()
    require("persistence").stop()
end, { desc = "Stop Persistence" })
