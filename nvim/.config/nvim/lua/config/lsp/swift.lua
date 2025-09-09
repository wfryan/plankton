vim.lsp.config.swift = {
	cmd = { "xcrun", "sourcekit-lsp" },
	filetypes = { "swift", "objectivec", "objectivecpp" },
}
vim.lsp.enable("sourcekit-lsp")
