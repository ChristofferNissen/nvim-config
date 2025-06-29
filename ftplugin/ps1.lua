vim.keymap.set({ "n", "x" }, "<leader>E", function()
    require("powershell").eval()
end)
