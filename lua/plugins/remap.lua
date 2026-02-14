vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Example: remap Esc in normal mode to clear search highlights
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-t>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-n>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader><leader>", function()
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
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cd> cprey<CR>")

vim.keymap.set("n", "<leader>ct", function()
	require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })
vim.keymap.set("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
vim.keymap.set("n", "<leader>th", function()
	require("nvchad.term").new({ pos = "sp" })
end, { desc = "terminal new horizontal term" })

vim.keymap.set("n", "<leader>tv", function()
	require("nvchad.term").new({ pos = "vsp" })
end, { desc = "terminal new vertical term" })

-- toggleable
vim.keymap.set({ "n", "t" }, "<A-v>", function()
	require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
end, { desc = "terminal toggleable vertical term" })

vim.keymap.set({ "n", "t" }, "<A-t>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "terminal toggleable horizontal term" })

vim.keymap.set({ "n", "t" }, "<A-f>", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" })
