return {
    {
        'rcarriga/nvim-notify',
        config = function()
            -- Optional: Configure nvim-notify here
            require("notify").setup({
                -- Your configuration options
            })
            vim.notify = require("notify")
        end
    },
}
