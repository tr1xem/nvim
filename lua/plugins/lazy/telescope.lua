return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			require("telescope").load_extension("undo")
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				extensions = {
					fzf = {},
				},
			})

			telescope.load_extension("fzf")

			local map = vim.keymap.set

			-- File pickers
			map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			map("n", "<C-f>", builtin.git_files, { desc = "Git files" })

			-- Grep pickers
			map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
			map(
				"n",
				"<leader>fz",
				"<cmd>Telescope current_buffer_fuzzy_find<CR>",
				{ desc = "telescope find in current buffer" }
			)
			map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
			-- map("n", "<leader>fw", function()
			-- 	builtin.grep_string({ search = vim.fn.expand("<cword>") })
			-- end, { desc = "Grep current word" })
			--
			-- map("n", "<leader>fW", function()
			-- 	builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
			-- end, { desc = "Grep WORD under cursor" })

			map("n", "<leader>fu", telescope.extensions.undo.undo, { desc = "undo" })
			map("n", "<leader>fus", function()
				telescope.extensions.undo.undo({ saved_only = true })
			end, { desc = "saved" })
			map("n", "<leader>f:", builtin.command_history, { desc = "command history" })
			map("n", "<leader>f/", builtin.search_history, { desc = "search history" })

			-- Help and buffers
			map("n", "<leader>fvh", builtin.help_tags, { desc = "Help tags" })
			map("n", "<leader>fb", function()
				builtin.buffers({
					sort_mru = true,
					ignore_current_buffer = true,
				})
			end, { desc = "Buffers (MRU)" })

			-- LSP references
			map({ "n", "v" }, "<leader>fr", builtin.lsp_references, {
				silent = true,
				noremap = true,
				desc = "LSP References",
			})

			-- Config files
			map("n", "<space>fc", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "Find config files" })
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
}
