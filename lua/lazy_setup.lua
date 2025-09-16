-- Active modules configuration
local active_modules = require("modules")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Collect plugin specifications from active modules
local plugins = {}

-- Function to load plugin specs from a module if it exists
local function load_module_plugins(module_name)
    local ok, module_plugins = pcall(require, module_name .. ".plugins")
    if ok then
        for _, plugin in ipairs(module_plugins) do
            table.insert(plugins, plugin)
        end
    end
end

-- -- Load active modules and their plugins
-- for module_name, enabled in pairs(active_modules) do
--     if enabled then
--         -- Add plugin specs
--         load_module_plugins(module_name)
--
--         -- Initialize the module
--         pcall(require, module_name)
--     end
-- end

-- Load active modules and their plugins
for module_name, enabled in pairs(active_modules) do
    if enabled then
        -- Add plugin specs
        load_module_plugins(module_name)

        -- Initialize the module
        local module_ok, module = pcall(require, module_name)
        if module_ok then
            if module_name ~= "ChristofferNissen" then
                -- If the module has a setup function, call it
                if type(module.setup) == "function" then
                    module.setup()
                end
            end

            -- Additionally try to load and run specific setup modules
            -- pcall(function()
            --     require(module_name .. ".lsp").setup()
            -- end)
        end
    end
end

-- Initialize lazy.nvim with collected plugins
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
        plugins,
    },
    defaults = {
        -- lazy = true,                      -- every plugin is lazy-loaded by default
    },
    rocks = { enabled = false }, -- disable rocks
    dev = {
        path = "~/.local/share/nvim/nix", -- path to your dev plugins
        fallback = false, -- fallback to git if not found
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    install = { colorscheme = { "tokyonight" } },
    -- automatically check for plugin updates
    checker = { enabled = true, notify = false },
})
