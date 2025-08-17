return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		-- "saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- NOTE: LSP Keybinds

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings
				-- Check `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
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

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>vrn", "<cmd>Lspsaga rename<CR>", opts)

				-- opts.desc = "Show buffer diagnostics"
				-- vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				-- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
				vim.keymap.set("n", "<leader>vd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				opts.desc = "Signature help"
				vim.keymap.set("i", "<C-h>", "<cmd>Lspsaga signature_help<CR>", opts)

				opts.desc = "Jump to prev diagnostic"
				vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
				opts.desc = "Jump to next diagnostic"
				vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
			end,
		})

		-- NOTE : Moved all this to Mason including local variables
		-- used to enable autocompletion (assign to every lsp server config)
		-- local capabilities = cmp_nvim_lsp.default_capabilities()
		-- Change the Diagnostic symbols in the sign column (gutter)

		-- Define sign icons for each severity
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		-- Set the diagnostic config with all icons
		vim.diagnostic.config({
			signs = {
				text = signs, -- Enable signs in the gutter
			},
			virtual_text = true, -- Specify Enable virtual text for diagnostics
			underline = true, -- Specify Underline diagnostics
			update_in_insert = false, -- Keep diagnostics active in insert mode
		})

		-- NOTE :
		-- Moved back from mason_lspconfig.setup_handlers from mason.lua file
		-- as mason setup_handlers is deprecated & its causing issues with lsp settings
		--
		-- Setup servers
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()
		-- Config lsp servers here
		-- lua_ls
		lspconfig.lua_ls.setup({
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
		lspconfig.emmet_ls.setup({
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

		-- emmet_language_server
		lspconfig.emmet_language_server.setup({
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
		lspconfig.denols.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		})

		require("lspconfig").clangd.setup({
			settings = {
				clangd = {
					InlayHints = {
						Designators = true,
						Enabled = true,
						ParameterNames = true,
						DeducedTypes = true,
					},
					fallbackFlags = { "-std=c++20" },
				},
			},
		})
		lspconfig.ruff.setup({
			init_options = {
				settings = {
					logLevel = "debug",
				},
			},
		})
		require("lspconfig").pyright.setup({
			settings = {
				pyright = {
					inlayHints = true,
					-- Using Ruff's import organizer
					disableOrganizeImports = true,
				},
				python = {
					analysis = {
						-- Ignore all files for analysis to exclusively use Ruff for linting
						ignore = { "*" },
					},
				},
			},
		})
		-- ts_ls (replaces tsserver)
		-- 		lspconfig.basedpyright.setup({
		-- 			capabilities = capabilities,
		-- 			settings = {
		-- 				basedpyright = {
		-- inlayHints = true,
		-- 					disableOrganizeImports = true,
		-- 					analysis = {
		-- 						-- Ignore all files for analysis to exclusively use Ruff for linting
		-- 						ignore = { "*" },
		-- 					},
		-- 				},
		-- 			},
		-- 		})
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			root_dir = function(fname)
				local util = lspconfig.util
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

		-- HACK: If using Blink.cmp Configure all LSPs here

		-- ( comment the ones in mason )
		-- local lspconfig = require("lspconfig")
		-- local capabilities = require("blink.cmp").get_lsp_capabilities() -- Import capabilities from blink.cmp

		-- Configure lua_ls
		-- lspconfig.lua_ls.setup({
		--     capabilities = capabilities,
		--     settings = {
		--         Lua = {
		--             diagnostics = {
		--                 globals = { "vim" },
		--             },
		--             completion = {
		--                 callSnippet = "Replace",
		--             },
		--             workspace = {
		--                 library = {
		--                     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
		--                     [vim.fn.stdpath("config") .. "/lua"] = true,
		--                 },
		--             },
		--         },
		--     },
		-- })
		--
		-- -- Configure tsserver (TypeScript and JavaScript)
		-- lspconfig.ts_ls.setup({
		--     capabilities = capabilities,
		--     root_dir = function(fname)
		--         local util = lspconfig.util
		--         return not util.root_pattern('deno.json', 'deno.jsonc')(fname)
		--             and util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git')(fname)
		--     end,
		--     single_file_support = false,
		--     on_attach = function(client, bufnr)
		--         -- Disable formatting if you're using a separate formatter like Prettier
		--         client.server_capabilities.documentFormattingProvider = false
		--     end,
		--     init_options = {
		--         preferences = {
		--             includeCompletionsWithSnippetText = true,
		--             includeCompletionsForImportStatements = true,
		--         },
		--     },
		-- })

		-- Add other LSP servers as needed, e.g., gopls, eslint, html, etc.
		-- lspconfig.gopls.setup({ capabilities = capabilities })
		-- lspconfig.html.setup({ capabilities = capabilities })
		-- lspconfig.cssls.setup({ capabilities = capabilities })
		vim.lsp.inlay_hint.enable(true)
	end,
}
