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

				opts.desc = "Open all folds"
				vim.keymap.set("n", "cuf", require("ufo").openAllFolds, opts)
				opts.desc = "Close all folds"
				vim.keymap.set("n", "cf", require("ufo").closeAllFolds, opts)

				-- opts.desc = "Signature help"
				-- vim.keymap.set("i", "<C-h>", "<cmd>Lspsaga signature_help<CR>", opts)

				opts.desc = "Jump to prev diagnostic"
				vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
				opts.desc = "Jump to next diagnostic"
				vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
			end,
		})

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

		-- perlnavigator
		vim.lsp.enable("perlnavigator")
		vim.lsp.config("perlnavigator", {
			capabilities = capabilities,
		})

		-- lua_ls
		vim.lsp.enable("lua_ls")
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
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
		})

		-- emmet_ls
		vim.lsp.enable("emmet_ls")
		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
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
		})

		-- qmljs
		-- vim.lsp.enable("qmlls")
		-- vim.lsp.config("qmlls",{
		-- 	capabilities = capabilities,
		-- })

		-- emmet_language_server
		vim.lsp.enable("emmet_language_server")
		vim.lsp.config("emmet_language_server", {
			capabilities = capabilities,
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
		})

		-- denols
		vim.lsp.enable("denols")
		vim.lsp.config("denols", {
			capabilities = capabilities,
			root_dir = vim.fs.dirname(vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1]),
		})

		-- clangd
		vim.lsp.enable("clangd")
		vim.lsp.config("clangd", {
			capabilities = capabilities,
			settings = {
				clangd = {
					fallbackFlags = { "-std=c++23", "-Wall", "-Wextra", "-Wunused-variable", "-fanalyzer" },
				},
			},
		})
		-- vim.lsp.config("pyright", {
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
		-- })
		-- vim.lsp.config("pylsp", {
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
		-- })
		-- vim.lsp.enable("pylsp")
		-- vim.lsp.enable("pyright")
		-- ts_ls (replaces tsserver)

		-- vim.lsp.config("basedpyright", {
		vim.lsp.enable("hyprls")
		vim.lsp.config("hyprls", {
			capabilities = capabilities,
		})

		-- basedpyright
		vim.lsp.enable("basedpyright")
		vim.lsp.config("basedpyright", {
			capabilities = capabilities,
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
		})

		vim.lsp.enable("gopls")
		-- ts_ls (replaces tsserver)
		vim.lsp.enable("ts_ls")
		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
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
		})

		-- vim.lsp.enable("gopls")
		-- vim.lsp.config("gopls",{ capabilities = capabilities })
		-- vim.lsp.enable("html")
		-- vim.lsp.config("html",{ capabilities = capabilities })
		-- vim.lsp.enable("cssls")
		-- vim.lsp.config("cssls",{ capabilities = capabilities })

		vim.lsp.enable("csharp_ls")
		vim.lsp.enable("elixirls")
		vim.lsp.enable("tailwindcss")
		vim.lsp.enable("cmake-language-server")
		vim.lsp.inlay_hint.enable(true)
		vim.keymap.set(
			"n",
			"<leader>ch",
			"<cmd>ClangdSwitchSourceHeader<cr>",
			{ desc = "Switch Source/Header (C/C++)" }
		)
	end,
}
