-- lua/ui/init.lua

-- UI module initialization
local M = {}

-- Apply UI configurations
function M.setup()
    -- if pcall(require, "tokyonight") then
    --     require("tokyonight").setup({
    --         style = "storm", -- Set the color scheme style
    --     })
    --     vim.cmd([[colorscheme tokyonight-storm]])
    -- end

    -- Additional UI settings
    -- vim.opt.cursorline = true
    -- vim.opt.signcolumn = "yes"

    -- Configure UI plugins after they're loaded
    -- if pcall(require, "lualine") then
    --     require("lualine").setup({
    --         options = {
    --             theme = "tokyonight",
    --             component_separators = { left = "|", right = "|" },
    --             section_separators = { left = "", right = "" },
    --         },
    --     })
    -- end
end

return M
