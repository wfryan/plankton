vim.lsp.config.go = {
	cmd = { "gopls" },
	filetypes = { "go" },
	root_markers = {
		"go.mod",
		".git",
	},
	settings = {},
}

vim.lsp.enable("go")
vim.lsp.enable("golangci_lint_ls")
