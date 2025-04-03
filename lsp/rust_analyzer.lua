---@type vim.lsp.Config
local config = {}

local function expand_config_variables(option)
    local var_placeholders = {
        ["${workspaceFolder}"] = function(_)
            return vim.lsp.buf.list_workspace_folders()[1]
        end,
    }

    if type(option) == "table" then
        local mt = getmetatable(option)
        local result = {}
        for k, v in pairs(option) do
            result[expand_config_variables(k)] = expand_config_variables(v)
        end
        return setmetatable(result, mt)
    end
    if type(option) ~= "string" then
        return option
    end
    local ret = option
    for key, fn in pairs(var_placeholders) do
        ret = ret:gsub(key, fn)
    end
    return ret
end

if string.match(vim.fn.getcwd(), vim.fn.expand("^$HOME/Projects/rust/rust$")) then
    config = {
        filetypes = { "rust", "toml.Cargo" },
        cmd = {
            "rustup",
            "run",
            "nightly",
            "rust-analyzer",
        },
        settings = {},
        root_dir = vim.fn.expand("$HOME/Projects/rust/rust"),
        on_init = function(client)
            local path = client.workspace_folders[1].name
            local config_file = vim.fs.joinpath(path, "src/etc/rust_analyzer_zed.json")
            if vim.uv.fs_stat(config_file) then
                -- load rust-lang/rust settings
                local file = io.open(config_file)
                local json = vim.json.decode(file:read("*a"))
                client.config.settings["rust-analyzer"] =
                    expand_config_variables(json.lsp["rust-analyzer"].initialization_options)
                client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
        end,
    }
else
    config = {
        cmd = {
            "rust-analyzer",
        },
        settings = {
            ["rust-analyzer"] = {
                diagnostics = {
                    styleLints = {
                        enable = true,
                    },
                },
                checkOnSave = true,
                check = {
                    command = "clippy",
                    features = "all",
                    allTargets = true,
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                    features = "all",
                },
                procMacro = {
                    enable = true,
                },
                imports = {
                    group = {
                        enable = false,
                    },
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                completion = {
                    postfix = {
                        enable = true,
                    },
                    -- snippets = {
                    -- 	custom = "None",
                    -- },
                },
            },
        },
        root_markers = { "Cargo.toml", "Cargo.lock", "build.rs" },
        filetypes = { "rust", "toml.Cargo" },
    }
end

config.capabilities = {
    experimental = {
        serverStatusNotification = true,
    },
}

return config
