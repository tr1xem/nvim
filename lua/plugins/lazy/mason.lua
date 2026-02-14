return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
	},
	config = function()
		dofile(vim.g.base46_cache .. "mason")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_pending = " ",
					package_installed = " ",
					package_uninstalled = " ",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_enable = false,
			-- servers for mason to install
			ensure_installed = {
				"lua_ls",
				-- "ts_ls", currently using a ts plugin
				"html",
				"cssls",
				"tailwindcss",
				"gopls",
				"emmet_ls",
				"emmet_language_server",
				"ruff",
				"basedpyright",
				-- "eslint",
				"marksman",
			},
		})

		mason_tool_installer.setup({
			max_concurrent_installers = 10,
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				-- "isort", -- python formatter
				"pylint",
				"clangd",
				"denols",
				-- { 'eslint_d', version = '13.1.2' },
			},
		})
	end,
}
