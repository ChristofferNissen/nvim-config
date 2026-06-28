-- Options
vim.loader.enable()

vim.g.editorconfig = true

-- Show blink.cmp's selected completion as inline ghost text.
-- Kept explicit (was implicitly nil -> disabled). Set to true to enable.
vim.g.ai_cmp = false

-- Configure diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = false,
    float = {
        border = "rounded",
        -- source = "always",
    },
})
