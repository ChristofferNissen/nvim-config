--@type vim.lsp.Config
return {
	cmd = { "azure-pipelines-language-server", "--stdio" },
	filetypes = { "azure-pipelines" },
	single_file_support = true,
	settings = {},
	root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
	-- capabilities = {
	-- 	textDocument = {
	-- 		foldingRange = {
	-- 			dynamicRegistration = false,
	-- 			lineFoldingOnly = true,
	-- 		},
	-- 	},
	-- },
}
