return {
	{
		"folke/trouble.nvim",
		lazy = false,
		keys = {
			{
				"<leader>tt",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
		config = function()
			require("trouble").setup({})
			--
			vim.keymap.set("n", "[t", function()
				require("trouble").next({ skip_groups = true, jump = true })
			end)

			vim.keymap.set("n", "]t", function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end)
		end,
	},
}
