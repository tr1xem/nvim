return {
	"neovim/nvim-lspconfig",
	event = "User FilePost",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"p00f/clangd_extensions.nvim",
	},
	config = function()
		-- NOTE: LSP Keybinds

		dofile(vim.g.base46_cache .. "lsp")
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings
				local opts = { buffer = ev.buf, silent = true }

				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client == nil then
					return
				end

				-- keymaps
				opts.desc = "Show LSP references/dereferences"
				vim.keymap.set("n", "<leader>vrr", "<cmd>Lspsaga finder def+ref<CR>", opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)

				--             opts.desc = "Go to declaration"
				-- vim.keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				-- opts.desc = "Show LSP implementations
				-- vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set("n", "<leader>vca", "<cmd>Lspsaga code_action<CR>", opts)
				-- vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>vrn", "<cmd>Lspsaga rename<CR>", opts)

				-- opts.desc = "Show buffer diagnostics"
				-- vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				-- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
				vim.keymap.set("n", "<leader>vd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

				opts.desc = "Show documentation for what is under cursor"
				-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
				vim.keymap.set("n", "K", function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						vim.cmd("Lspsaga hover_doc")
						-- vim.lsp.buf.hover()
					end
				end, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				opts.desc = "Jump to prev diagnostic"
				vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

				opts.desc = "Jump to next diagnostic"
				vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
			end,
		})

		vim.keymap.set("n", "cuf", require("ufo").openAllFolds, { desc = "Open all folds" })

		vim.keymap.set("n", "cf", require("ufo").closeAllFolds, { desc = "Close all folds" })

		vim.keymap.set(
			"n",
			"<leader>ch",
			"<cmd>ClangdSwitchSourceHeader<cr>",
			{ desc = "Switch Source/Header (C/C++)" }
		)
		local servers = {
			csharp_ls = {},
			elixirls = {},
			tailwindcss = {},
			cmake_language_server = {},
			bashls = {},
			perlnavigator = {},
			hyprls = {},
			-- gopls = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},

			emmet_ls = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				},
			},
			emmet_language_server = {
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"pug",
					"typescriptreact",
				},
				init_options = {
					includeLanguages = {},
					excludeLanguages = {},
					extensionsPath = {},
					preferences = {},
					showAbbreviationSuggestions = true,
					showExpandedAbbreviation = "always",
					showSuggestionsAsSnippets = false,
					syntaxProfiles = {},
					variables = {},
				},
			},

			denols = {
				root_dir = vim.fs.dirname(vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1]),
			},
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
				},
			},
			basedpyright = {
				settings = {
					basedpyright = {
						inlayHints = true,
						disableOrganizeImports = true,
						analysis = {
							-- Ignore all files for analysis to exclusively use Ruff for linting
							-- Enable diagnostics
							-- ignore = { "*" },
							typeCheckingMode = "basic",
						},
					},
				},
			},
			ts_ls = {
				root_dir = function(fname)
					local util = require("lspconfig").util
					return not util.root_pattern("deno.json", "deno.jsonc")(fname)
						and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
				end,
				single_file_support = false,
				init_options = {
					preferences = {
						includeCompletionsWithSnippetText = true,
						includeCompletionsForImportStatements = true,
					},
				},
			},
			-- pylsp = {
			-- 	settings = {
			-- 		pylsp = {
			-- 			signature = {
			-- 				formatter = "ruff",
			-- 			},
			-- 			plugins = {
			-- 				rope_autoimport = {
			-- 					enabled = false,
			-- 					-- 	memory = true,
			-- 					completions = {
			-- 						enabled = true,
			-- 					},
			-- 					code_actions = {
			-- 						enabled = true,
			-- 					},
			-- 				},
			-- 				-- pylsp_mypy = { enabled = true },
			-- 				pylsp_ruff = { enabled = true },
			-- 			},
			-- 		},
			-- 	},
			-- },
			-- pyright = {
			-- 	settings = {
			-- 		pyright = {
			-- 			inlayHints = true,
			-- 			-- Using Ruff's import organizer
			-- 			disableOrganizeImports = true,
			-- 		},
			-- 		python = {
			-- 			analysis = {
			-- 				ignore = { "*" },
			-- 			},
			-- 		},
			-- 	},
			-- },
			-- qmlls = {},
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		capabilities.textDocument.completion.completionItem = {
			documentationFormat = { "markdown", "plaintext" },
			snippetSupport = true,
			preselectSupport = true,
			insertReplaceSupport = true,
			labelDetailsSupport = true,
			deprecatedSupport = true,
			commitCharactersSupport = true,
			tagSupport = { valueSet = { 1 } },
			resolveSupport = {
				properties = {
					"documentation",
					"detail",
					"additionalTextEdits",
				},
			},
		}
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		for name, opts in pairs(servers) do
			opts.capabilities = capabilities
			vim.lsp.config(name, opts)
			vim.lsp.enable(name)
		end

		vim.lsp.inlay_hint.enable(true)
		-- if you dont want to call the enable method in the loop, just pass a table.
		-- vim.lsp.enable(vim.tbl_keys(servers))
		-- vim.lsp.enable({"pyright", "clangd"})
	end,
}
