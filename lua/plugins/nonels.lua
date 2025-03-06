return {
	"nvimtools/none-ls.nvim",
	opts = function(_, opts)
		local nls = require("null-ls")
		opts.sources = vim.list_extend(opts.sources or {}, {
			nls.builtins.code_actions.gitsigns,
			-- ts
			nls.builtins.formatting.biome,
			-- other
			nls.builtins.formatting.stylua,
			nls.builtins.formatting.shfmt,
			nls.builtins.formatting.black,
			-- yaml
			nls.builtins.diagnostics.yamllint,
			nls.builtins.formatting.yamlfmt,
			-- go
			nls.builtins.code_actions.gomodifytags,
			nls.builtins.code_actions.impl,
			nls.builtins.formatting.goimports,
			nls.builtins.formatting.gofumpt,
			-- markdown
			nls.builtins.diagnostics.markdownlint_cli2,
			-- terraform
			nls.builtins.formatting.packer,
			nls.builtins.formatting.terraform_fmt,
			nls.builtins.diagnostics.terraform_validate,
		})
		return opts
	end,
}
