vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

require("plugins.set")
require("plugins.remap")
require("plugins.lazy_init")
require("mini.tabline").setup()
vim.opt.colorcolumn = ""
local augroup = vim.api.nvim_create_augroup
local trixgroup = augroup("trixgroup", {})
local yank_group = augroup("HighlightYank", {})

local autocmd = vim.api.nvim_create_autocmd
function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

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

autocmd({ "BufWritePre" }, {
	group = trixgroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = trixgroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		local keymap = vim.keymap.set

		keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
		keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
		keymap("n", "<leader>vws", "<cmd>Lspsaga workspace_symbol<CR>", opts)
		keymap("n", "<leader>vd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
		keymap("n", "<leader>vca", "<cmd>Lspsaga code_action<CR>", opts)
		keymap("n", "<leader>vrr", "<cmd>Lspsaga finder<CR>", opts)
		keymap("n", "<leader>vrn", "<cmd>Lspsaga rename<CR>", opts)
		keymap("i", "<C-h>", "<cmd>Lspsaga signature_help<CR>", opts)
		keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
		keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

vim.keymap.set("n", "<leader>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 15)
end)

require("lualine").setup({
	options = {
		theme = "catppuccin",
	},
})

vim.cmd.colorscheme("catppuccin")

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

vim.keymap.set("n", "<leader>f", function()
	require("conform").format()
end, { noremap = true, silent = true })

require("conform").setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 5000,
		lsp_format = "fallback",
	},
})
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
