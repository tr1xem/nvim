return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				extensions = {
					fzf = {},
				},
			})

			telescope.load_extension("fzf")

			local keymap = vim.keymap.set

			-- File pickers
			keymap("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
			keymap("n", "<C-p>", builtin.git_files, { desc = "Git files" })

			-- Grep pickers
			keymap("n", "<leader>pws", function()
				builtin.grep_string({ search = vim.fn.expand("<cword>") })
			end, { desc = "Grep current word" })

			keymap("n", "<leader>pWs", function()
				builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
			end, { desc = "Grep WORD under cursor" })

			keymap("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Grep user input" })

			-- Help and buffers
			keymap("n", "<leader>vh", builtin.help_tags, { desc = "Help tags" })
			keymap("n", "<leader>b", function()
				builtin.buffers({
					sort_mru = true,
					ignore_current_buffer = true,
				})
			end, { desc = "Buffers (MRU)" })

			-- LSP references
			keymap({ "n", "v" }, "<leader>sr", builtin.lsp_references, {
				silent = true,
				noremap = true,
				desc = "LSP References",
			})

			-- Config files
			keymap("n", "<space>en", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "Find config files" })
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
}
