return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local callTelescope = function(input)
				-- local theme = require("telescope.themes").get_dropdown()teles
				-- input(theme)
				input()
			end

			vim.keymap.set("n", "gi", function()
				callTelescope(require("telescope.builtin").lsp_implementations)
			end, { silent = true })

			vim.keymap.set("n", "gr", function()
				require("telescope.builtin").lsp_references({ include_declaration = false })
			end, { silent = true })

			-- vim.keymap.set("n", "gs", function()
			-- 	callTelescope(require("telescope.builtin").lsp_document_symbols)
			-- end, { silent = true })

			-- vim.keymap.set("n", "gd", function()
			-- 	require("telescope.builtin").lsp_definitions()
			-- end, { silent = true })

			vim.keymap.set("n", "<leader>fg", function()
				telescope.extensions.live_grep_args.live_grep_args()
			end, { silent = true })

			vim.keymap.set("n", "<leader>tc", function()
				require("telescope.builtin").resume({ cache_index = 1 })
			end)

			vim.keymap.set("v", "<leader>fg", function()
				require("telescope.builtin").grep_string()
			end, { silent = true })

			vim.keymap.set("n", "<leader>gh", function()
				require("telescope.builtin").highlights()
			end, { silent = true })

			vim.keymap.set("n", "<leader>gp", function()
				require("telescope.builtin").diagnostics({
					show_all = true,
					severity = { "Error" },
				})
			end, { silent = true })

			vim.keymap.set("n", "gt", function()
				callTelescope(require("telescope.builtin").lsp_type_definitions)
			end, { silent = true })

			vim.keymap.set({ "i", "n" }, "<A-f>", function()
				callTelescope(require("telescope.builtin").current_buffer_fuzzy_find)
			end, { silent = true })

			local lga_actions = require("telescope-live-grep-args.actions")
			telescope.setup({
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						file_ignore_patterns = { "node_modules", "pnpm-lock.yaml", "package-lock.json" },
						additional_args = function(_)
							return { "--hidden" }
						end,
						hidden = true,
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
								-- freeze the current list and start a fuzzy search in the frozen list
								-- ["<C-m>"] = actions.to_fuzzy_refine,
							},
						},
						-- ... also accepts theme settings, for example:
						-- theme = "dropdown", -- use dropdown theme
						-- theme = { }, -- use own theme spec
						-- layout_config = { mirror=true }, -- mirror preview pane
					},

					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},

				defaults = {
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					sorting_strategy = "ascending",
					layout_strategy = "flex",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							width = 0.90,
							height = 0.90,
							preview_width = 0.5,
						},
						vertical = {
							width = 0.90,
							height = 0.90,
							preview_width = 0.5,
						},
					},

					path_display = { shorten = 1 },
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--ignore-file",
						".gitignore",
						"--ignore-file",
						"swag/",
						"--ignore-file",
						"docs/",
					},
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-c>"] = false,
							["<C-h>"] = "which_key",
							["<A-j>"] = "move_selection_next",
							["<A-k>"] = "move_selection_previous",
							["<A-e>"] = "move_selection_previous",
							["<C-u>"] = false,
						},
					},
				},
				-- file_ignore_patterns = { ".git/", "node_modules/", "vendor/", "swag/", "docs/" },
			})

			telescope.load_extension("live_grep_args")
			telescope.load_extension("ui-select")
		end,
	},
	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		config = function()
			require("telescope").load_extension("smart_open")
		end,
		dependencies = {
			"kkharji/sqlite.lua",
			-- Only required if using match_algorithm fzf
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
		keys = {
			{
				"<A-e>",
				function()
					require("telescope").extensions.smart_open.smart_open({ cwd_only = true })
				end,
				mode = { "n", "v" },
				desc = "Smart open files",
			},
		},
	},
	{
		"debugloop/telescope-undo.nvim",
		dependencies = { -- note how they're inverted to above example
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		keys = {
			{ -- lazy style key map
				"<leader>u",
				"<cmd>Telescope undo<cr>",
				desc = "undo history",
			},
		},
		opts = {
			-- don't use `defaults = { }` here, do this in the main telescope spec
			extensions = {
				undo = {
					-- telescope-undo.nvim config, see below
				},
				-- no other extensions here, they can have their own spec too
			},
		},
		config = function(_, opts)
			-- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
			-- configs for us. We won't use data, as everything is in it's own namespace (telescope
			-- defaults, as well as each extension).
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},
}
