-- -- Enable Neovim's built-in inlay hints for supported LSP clients
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
-- 	callback = function(args)
-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 		if client and client.server_capabilities.inlayHintProvider then
-- 			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
-- 		end
-- 	end,
-- })

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"stevearc/conform.nvim",
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"onsails/lspkind.nvim",
			"garymjr/nvim-snippets",
		},
		config = function()
			-- Formatter setup
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black", "ruff" },
					rust = { "rustfmt", lsp_format = "fallback" },
					json = { "clang-format", "json_tool" },
					cpp = { "clang-format" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					css = { "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
				},
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true)
					end
					-- whatever other lsp config you want
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Progress UI
			require("fidget").setup({})
			-- BasedPyright LSP
			require("lspconfig").basedpyright.setup({
				capabilities = capabilities,
				settings = {
					basedpyright = {
						analysis = {
							ignorePatterns = { "*.pyi" },
							diagnosticSeverityOverrides = {
								reportCallIssue = "warning",
								reportUnreachable = "warning",
								reportAttributeAccessIssue = "none",
								reportUnknownVariableType = "none",
								reportUnknownLamdaType = "none",
								reportUnknownParameterType = "none",
								reportMissingParameterType = "none",
								reportUnknownMemberType = "none",
								reportArgumentType = "none",
								reportAny = "none",
								reportUnknownArgumentType = "none",
								-- reportUnannotatedClassAttribute = "none",
								reportUnusedImport = "warning",
								typeCheckingMode = "basic",
								reportUnusedCoroutine = "warning",
							},
							-- diagnosticMode = "workspace",
							diagnosticMode = "openFilesOnly",
							typeCheckingMode = "basic",
							reportCallIssue = "none",
							disableOrganizeImports = false,
						},
					},
				},
			})

			-- Mason setup
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "basedpyright", "rust_analyzer", "gopls", "clangd" },
				handlers = {
					-- Default handler
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					-- Zig LSP
					zls = function()
						require("lspconfig").zls.setup({
							root_dir = require("lspconfig").util.root_pattern(".git", "build.zig", "zls.json"),
							capabilities = capabilities,
							settings = {
								zls = {
									enable_inlay_hints = true, -- Re-enable zls inlay hints
									enable_snippets = true,
									warn_style = true,
								},
							},
						})
						vim.g.zig_fmt_parse_errors = 0
						vim.g.zig_fmt_autosave = 1
					end,

					-- Lua LSP
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
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
		end,
	},
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
