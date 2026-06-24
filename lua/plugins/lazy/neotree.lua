return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
		"s1n7ax/nvim-window-picker",
	},
	lazy = false, -- neo-tree will lazily load itself

	config = function()
		require("neo-tree").setup({
			filesystem = {
				hijack_netrw_behavior = "disabled",
				use_libuv_file_watcher = true,
			},
			buffers = {
				show_unloaded = true,
			},
			document_symbols = {
				follow_cursor = true,
			},
			sources = {
				"buffers",
				"document_symbols",
				"filesystem",
				"git_status",
			},
		})
		vim.keymap.set("n", "<leader>eb", "<cmd>Neotree toggle buffers<cr>", { desc = "buffers" })
		vim.keymap.set("n", "<leader>ef", "<cmd>Neotree toggle .<cr>", { desc = "files" })
		vim.keymap.set("n", "<leader>eg", "<cmd>Neotree toggle git_status<cr>", { desc = "git status" })
		vim.keymap.set("n", "<leader>eq", "<cmd>Neotree close<cr>", { desc = "close" })
		vim.keymap.set("n", "<leader>es", "<cmd>Neotree document_symbols right<cr>", { desc = "document symbols" })
		-- ...
		--- if you use vim-illuminate:
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("Modular_NeoTreeNoIlluminate", { clear = true }),
			pattern = { "neo-tree" },
			callback = function(args)
				local bufnr = args.buf

				vim.api.nvim_buf_call(bufnr, vim.cmd.IlluminateToggleBuf)
			end,
		})
	end,
}
