vim.lsp.config.swift = {
        on_attach = on_attach, -- Re-use our on_attach function
				capabilities = capabilities, -- Re-use our capabilities
				cmd = { "xcrun", "sourcekit-lsp" },
				filetypes = { "swift", "objectivec", "objectivecpp" },
}
vim.lsp.enable("sourcekit")
