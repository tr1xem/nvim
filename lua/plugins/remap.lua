vim.g.mapleader = " "
local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex)

-- Example: remap Esc in normal mode to clear search highlights
map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
map("i", "<C-c>", "<Esc>")

map("n", "Q", "<nop>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
map("n", "<leader>f", vim.lsp.buf.format)

map("n", "<C-t>", "<cmd>cnext<CR>zz")
map("n", "<C-n>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

map("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

map("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

map("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- No arrow navigation
vim.api.nvim_set_keymap("n", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", "<Nop>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Right>", "<Nop>", { noremap = true, silent = true })
map("n", "<M-j>", "<cmd>cnext<CR>")
map("n", "<M-k>", "<cd> cprey<CR>")

-- NVCHAD
map("n", "<leader>ct", function()
	require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("n", "<leader>th", function()
	require("nvchad.term").new({ pos = "sp" })
end, { desc = "terminal new horizontal term" })

map("n", "<leader>tv", function()
	require("nvchad.term").new({ pos = "vsp" })
end, { desc = "terminal new vertical term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
	require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-t>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-f>", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" })

-- Leetcode
map("n", "<leader>ld", function()
	vim.cmd("Leet")
end, { desc = "Open Leetcode dashboard" })

map("n", "<leader>lt", function()
	vim.cmd("Leet test")
end, { desc = "Leetcode test" })
map("n", "<leader>ls", function()
	vim.cmd("Leet submit")
end, { desc = "Leetcode submit" })
map("n", "<leader>lh", function()
	vim.cmd("Leet hints")
end, { desc = "Leetcode hints" })

map("n", "<leader>lh", function()
	vim.cmd("Leet hints")
end, { desc = "Leetcode hints" })
map("n", "<leader>lm", function()
	vim.cmd("Leet menu")
end, { desc = "Leetcode menu" })
map("n", "<leader>lb", function()
	vim.cmd("Leet tabs")
end, { desc = "Leetcode tabs" })
map("n", "<leader>lc", function()
	vim.cmd("Leet console")
end, { desc = "Leetcode console" })
