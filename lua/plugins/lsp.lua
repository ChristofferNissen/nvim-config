return {
	{
		"williamboman/mason.nvim",
		-- opts = { ensure_installed = { "markdownlint-cli2", "markdown-toc" } },
		opts = function(_, opts)
			opts.ensure_installed = { "markdownlint-cli2", "markdown-toc" }
			vim.list_extend(opts.ensure_installed, { "codelldb" })
			if diagnostics == "bacon-ls" then
				vim.list_extend(opts.ensure_installed, { "bacon" })
			end
		end,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		lazy = true,
		config = false,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "onsails/lspkind.nvim" },
			{ "L3MON4D3/LuaSnip" },
			--     -- Snippet Collection (Optional)
			{ "rafamadriz/friendly-snippets" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
		},
		config = function()
			local cmp = require("cmp")
			-- local cmp_format = require('lsp-zero').cmp_format()
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local cmp_mappings = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			local lspkind = require("lspkind")

			cmp.setup({
				mapping = cmp_mappings,
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 75,
						ellipsis_char = "...",
						symbol_map = {
							Copilot = "",
							Supermaven = "",
						},
					}),
				},
				sources = {
					{ name = "supermaven" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "copilot" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "render-markdown" },
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				opts = { ensure_installed = { "goimports", "gofumpt" } },
			},

			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			local lsp = require("lsp-zero")
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.nu = {
				install_info = {
					url = "https://github.com/nushell/tree-sitter-nu",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "nu",
			}

			local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function()
					vim.lsp.buf.format({ timeout_ms = 200 })
				end,
				group = format_sync_grp,
			})

			local lsp_attach = function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts)
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				client.server_capabilities.semanticTokensProvider = nil
			end

			lsp.extend_lspconfig({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				lsp_attach = lsp_attach,
				float_border = "rounded",
				sign_text = true,
				set_lsp_keymaps = { preserve_mappings = false },
			})

			local lspconfig = require("lspconfig")

			lspconfig.marksman.setup({})

			lspconfig.gleam.setup({})

			lspconfig.nushell.setup({
				command = { "nu", "--lsp" },
				filetypes = { "nu" },
				root_dir = require("lspconfig.util").find_git_ancestor,
				single_file_support = true,
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				update_in_insert = true,
				underline = true,
				severity_sort = false,
				float = true,
			})

			lspconfig.gopls.setup({
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "gopls", "terraformls", "yamlls" },
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({})
					end,

					gopls = function(_, opts)
						-- workaround for gopls not supporting semanticTokensProvider
						-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
						lsp_attach = function(client, bufnr)
							local opts = { buffer = bufnr, remap = false }
							vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
							vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
							vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol,
								opts)
							vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
							vim.keymap.set("n", "[d", function()
								vim.diagnostic.jump({ count = -1, float = true })
							end, opts)
							vim.keymap.set("n", "]d", function()
								vim.diagnostic.jump({ count = 1, float = true })
							end, opts)
							vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
							vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
							vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
							vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
							vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
							client.server_capabilities.semanticTokensProvider = nil
						end
						lsp.on_attach(function(client, _)
							if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
								local semantic = client.config.capabilities.textDocument
								.semanticTokens
								client.server_capabilities.semanticTokensProvider = {
									full = true,
									legend = {
										tokenTypes = semantic.tokenTypes,
										tokenModifiers = semantic.tokenModifiers,
									},
									range = true,
								}
							end
						end, "gopls")
						-- end workaround
					end,

					bacon_ls = { enabled = diagnostics == "bacon-ls" },
					rust_analyzer = { enabled = false },

					yamlls = function()
						lspconfig.yamlls.setup({
							settings = {
								yaml = {
									format = {
										enable = true,
									},
									-- schemas = { kubernetes = '*.yaml' },
									validate = true,
									schemaStore = {
										-- Must disable built-in schemaStore support to use
										-- schemas from SchemaStore.nvim plugin
										enable = false,
										-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
										url = "",
									},
									schemas = require("schemastore").yaml.schemas(),
								},
							},
						})
					end,

					lua_ls = function()
						lspconfig.lua_ls.setup({
							on_init = function(client)
								lsp.nvim_lua_settings(client, {})
							end,
						})
					end,

					nil_ls = function()
						local nil_ls_opts = {
							settings = {},
						}
						nil_ls_opts.settings["nil"] = {
							formatting = {
								command = { "nixpkgs-fmt" },
							},
						}
						lspconfig.nil_ls.setup(nil_ls_opts)
					end,
				},
			})
		end,
	},
}
