-- lua/yaml/lsp.lua

-- Setup YAML LSP using Neovim 0.11's native LSP config
local M = {}

function M.setup()
    -- Don't run setup immediately - defer it to happen after plugins load
    vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        callback = function()
            M.setup_lsp()
        end,
        once = true,
    })
end

-- This is the actual setup function that will run after plugins are loaded
function M.setup_lsp()
    -- Make sure mason is available to install yamlls
    local has_mason, mason = pcall(require, "mason")
    if has_mason then
        mason.setup()

        -- Install yaml-language-server if not already installed
        local has_mason_registry, mr = pcall(require, "mason-registry")
        if has_mason_registry then
            local pkg = mr.get_package("yaml-language-server")
            if not pkg:is_installed() then
                pkg:install()
            end
            local pkg = mr.get_package("azure-pipelines-language-server")
            if not pkg:is_installed() then
                pkg:install()
            end
            local pkg = mr.get_package("helm-ls")
            if not pkg:is_installed() then
                pkg:install()
            end
            local pkg = mr.get_package("gh-actions-language-server")
            if not pkg:is_installed() then
                pkg:install()
            end
        end
    end

    -- Configure LSP without the schemas
    if vim.lsp and vim.lsp.config then
        -- Configure the YAML language server using Neovim 0.11's native config API
        --@type vim.lsp.Config
        vim.lsp.config.yamlls = {
            cmd = { "yaml-language-server", "--stdio" },
            capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            },
            settings = {
                yaml = {
                    keyOrdering = false,
                    format = {
                        enable = true,
                    },
                    -- validate = true,
                    redhat = { telemetry = { enabled = false } },
                    schemaStore = {
                        -- Must disable built-in schemaStore support to use
                        -- schemas from SchemaStore.nvim plugin
                        enable = false,
                        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                        url = "",
                    },
                },
            },
            single_file_support = true,
            filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
        }
        --@type vim.lsp.Config
        vim.lsp.config.azure_pipelines_ls = {
            cmd = { "azure-pipelines-language-server", "--stdio" },
            filetypes = { "azure_pipelines" },
            single_file_support = true,
            capabilities = {
                textDocument = {
                    foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    },
                },
            },
            settings = {
                yaml = {
                    completions = true,
                    validate = true,
                    redhat = { telemetry = { enabled = false } },
                    schemas = {
                        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                            "*",
                        },
                    },
                    schemaStore = {
                        -- Must disable built-in schemaStore support to use
                        -- schemas from SchemaStore.nvim plugin
                        enable = false,
                        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                        url = "",
                    },
                },
            },
            root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
            root_markers = { "azure-pipelines.yml" },
        }
        --@type vim.lsp.Config
        vim.lsp.config.helm_ls = {
            cmd = { "helm_ls", "serve" }, -- adjust if your binary has a different name/location
            filetypes = { "helm" }, -- or {"yaml"} if you want it on all YAML, but "helm" is recommended
            root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
            root_markers = { "Chart.yaml" },
            settings = {}, -- add custom settings here if needed
        }
        ---@type vim.lsp.Config
        vim.lsp.config.gh_actions_ls = {
            -- Optional: specify the command if not in PATH
            cmd = { "gh-actions-language-server", "--stdio" },
            -- Optional: custom filetypes
            filetypes = { "github-actions" },
            -- Optional: root directory logic
            root_markers = { ".github/workflows", ".git" },
            -- Optional: any custom settings
            settings = {
                -- Add your custom settings here
            },
            -- Optional: on_attach and capabilities for completion, etc.
            -- on_attach = function(client, bufnr)
            --   -- keymaps, etc.
            -- end,
            -- capabilities = capabilities,
        }
    end

    local has_schemastore, schemastore = pcall(require, "schemastore")
    if has_schemastore then
        local schemastore_schemas = schemastore.yaml.schemas({
            select = {
                "Azure Pipelines",
                "Argo Workflows",
                "Argo Events",
                "GitHub Action",
                "GitHub Workflow",
                "Taskfile config",
                "kustomization.yaml",
                "docker-compose.yml",
                "openapi.json",
                "gitlab-ci",
                "dependabot-v2.json",
                "Helm Chart.yaml",
                "Helm Chart.lock",
                "prettierrc.json",
            },
        })

        local custom_schemas = {
            -- kubernetes = { "deploy/**/*.yaml", "deploy/**/*.yml" },
        }

        local function merge_tables(t1, t2)
            local result = {}
            for k, v in pairs(t1) do
                result[k] = v
            end
            for k, v in pairs(t2) do
                result[k] = v
            end
            return result
        end

        local combined_schemas = merge_tables(schemastore_schemas, custom_schemas)

        -- Configure the YAML language server using Neovim 0.11's native config API
        if vim.lsp and vim.lsp.config then
            vim.lsp.config.yamlls.settings.yaml.schemas = combined_schemas
        end
    end

    -- Configure LSP with the schemas
    if vim.lsp and vim.lsp.config then
        -- Neovim 0.11+ approach
        vim.lsp.enable({
            "azure_pipelines_ls",
            "gh_actions_ls",
            "helm_ls",
            "yamlls",
        })
    end
end

return M
