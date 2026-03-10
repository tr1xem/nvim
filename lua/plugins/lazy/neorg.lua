return {
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.keybinds"] = {
						config = {
							default_keybinds = true,
						},
					},
					["core.concealer"] = {
						config = {
							icon_preset = "diamond",
						},
					},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/dotfiles/personal/personal/neorg/",
								cpp = "~/dotfiles/personal/personal/Notes/C++/",
								code = "~/dotfiles/personal/personal/Notes/",
							},
							default_workspace = "notes",
						},
					},
					["core.export"] = {},
					["core.summary"] = {},
					["core.text-objects"] = {},
				},
			})
			vim.keymap.set("i", "<C-CR>", "<Plug>(neorg.itero.next-iteration)", {})

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			relative_to_current_file = true,
			filetypes = {
				norg = {
					url_encode_path = true,
					template = ".image $FILE_PATH",
					download_images = false,
				},
			},
		},
		keys = {
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
}
