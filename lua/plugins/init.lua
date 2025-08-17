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
