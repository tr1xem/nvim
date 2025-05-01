return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"stevearc/conform.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
		},

		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black", "ruff" },
					rust = { "rustfmt", lsp_format = "fallback" },
					json = { "clang-format", "json_tool" },
					cpp = { "clang-format" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
				},
			})
			-- local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			-- local capabilities = vim.tbl_deep_extend(
			--     "force",
			--     {},
			--     require('blink.cmp').get_lsp_capabilities({}, false),
			--     vim.lsp.protocol.make_client_capabilities(),
			--     cmp_lsp.default_capabilities())
			-- --
			require("fidget").setup({})
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"gopls",
					"pyright",
					"clangd",
				},
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					zls = function()
						local lspconfig = require("lspconfig")
						lspconfig.zls.setup({
							root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
							settings = {
								zls = {
									enable_inlay_hints = true,
									enable_snippets = true,
									warn_style = true,
								},
							},
						})
						vim.g.zig_fmt_parse_errors = 0
						vim.g.zig_fmt_autosave = 1
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = {
										globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
									},
								},
							},
						})
					end,
				},
			})

			-- local cmp_select = { behavior = cmp.SelectBehavior.Select }

			-- cmp.setup({
			--     snippet = {
			--         expand = function(args)
			--             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			--         end,
			--     },
			--     mapping = cmp.mapping.preset.insert({
			--         ['<C-p>'] = cmp.mapping.select_prev_item(),
			--         ['<C-n>'] = cmp.mapping.select_next_item(),
			--         ['<C-y>'] = cmp.mapping.confirm({ select = true }),
			--         ["<C-Space>"] = cmp.mapping.complete(),
			--     }),
			--     sources = cmp.config.sources({
			--
			--         {name = 'path'},
			--         {name = 'blink.cmp'},
			--         { name = "copilot", group_index = 2 },
			--         { name = 'luasnip' }, -- For luasnip users.
			--     })
			-- })
			--
			-- vim.diagnostic.config({
			--     -- update_in_insert = true,
			--     float = {
			--         focusable = false,
			--         style = "minimal",
			--         border = "rounded",
			--         source = "always",
			--         header = "",
			--         prefix = "",
			--     },
			-- })
		end,
	},
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("inlay-hints").setup()
		end,
	},
	{ "onsails/lspkind.nvim" },
	{
		"garymjr/nvim-snippets",
		keys = {
			{
				"<Tab>",
				function()
					if vim.snippet.active({ direction = 1 }) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
						return
					end
					return "<Tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<Tab>",
				function()
					vim.schedule(function()
						vim.snippet.jump(1)
					end)
				end,
				expr = true,
				silent = true,
				mode = "s",
			},
			{
				"<S-Tab>",
				function()
					if vim.snippet.active({ direction = -1 }) then
						vim.schedule(function()
							vim.snippet.jump(-1)
						end)
						return
					end
					return "<S-Tab>"
				end,
				expr = true,
				silent = true,
				mode = { "i", "s" },
			},
		},
	},
}
