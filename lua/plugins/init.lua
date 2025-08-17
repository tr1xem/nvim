-- Key mappings
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

-- Plugin configurations
require("plugins.set") -- General settings
require("plugins.remap") -- Key mappings
require("plugins.lazy_init") -- Lazy.nvim setup

-- Mini tabline setup
-- require("mini.tabline").setup()

-- Disable color column
vim.opt.colorcolumn = ""

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yank
local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- Remove trailing whitespace on save
local trixgroup = augroup("trixgroup", {})
autocmd("BufWritePre", {
	group = trixgroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- LSP key mappings
-- autocmd("LspAttach", {
-- 	group = trixgroup,
-- 	callback = function(e)
-- 		local opts = { buffer = e.buf }
-- 		local keymap = vim.keymap.set
--
-- 		keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
-- 		keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
-- 		keymap("n", "<leader>vws", "<cmd>Lspsaga workspace_symbol<CR>", opts)
-- 		keymap("n", "<leader>vd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
-- 		keymap("n", "<leader>vca", "<cmd>Lspsaga code_action<CR>", opts)
-- 		keymap("n", "<leader>vrr", "<cmd>Lspsaga finder<CR>", opts)
-- 		keymap("n", "<leader>vrn", "<cmd>Lspsaga rename<CR>", opts)
-- 		keymap("i", "<C-h>", "<cmd>Lspsaga signature_help<CR>", opts)
-- 		keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
-- 		keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
-- 	end,
-- })

-- Terminal settings
autocmd("TermOpen", {
	group = augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

-- Open terminal in a new split
vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
end)

-- Colorscheme
vim.cmd("colorscheme tokyonight")

-- Cord setup
require("cord").setup({
	display = {},
	buttons = {
		{
			label = function(opts)
				return opts.repo_url and "View Repository"
			end,
			url = function(opts)
				return opts.repo_url
			end,
		},
	},
})

-- Conform setup
require("conform").setup({
	format_on_save = {
		timeout_ms = 5000,
		lsp_format = "fallback",
	},
})

-- Diagnostic signs
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})
require("notify").setup({
	background_colour = "#000000",
})
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })

-- Disable hover capability from Ruff
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})
