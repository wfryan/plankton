-- LSP
return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-jdtls",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"vimls",

					-- Go
					"gopls",
					"golangci_lint_ls",
					--
					-- Lua
					"lua_ls",
					-- Bash
					"bashls",

					-- JSON
					"jsonls",

					-- Python
					"pyright",

					-- YAML
					"yamlls",

					-- Rust
					"rust_analyzer",

					-- Java
					"jdtls",
					"gradle_ls",

					-- HTML
					"html",
					-- JavaScript/TypeScript
					"ts_ls",

					"vtsls",
					"vuels",

					"tailwindcss",
					"eslint",
					"cssls",
					-- "cssmodules-language-server",

					-- C/C++
					"clangd",

					-- Swift
					"swiftls",
					-- Docker
					-- "hadolint",
				},
				automatic_installation = true,
				automatic_enable = false,
			})
		end,
	},
	{
		"artemave/workspace-diagnostics.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require('lspconfig')
			lspconfig.swiftls.setup {
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			}
		end,
	}
}
