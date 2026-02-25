return {
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
							notes = "~/personal/neorg/",
							cpp = "~/personal/Notes/C++/",
							code = "~/personal/Notes/",
						},
						default_workspace = "notes",
					},
				},
				["core.summary"] = {},
				["core.text-objects"] = {},
			},
		})
		vim.keymap.set("i", "<C-CR>", "<Plug>(neorg.itero.next-iteration)", {})

		vim.wo.foldlevel = 99
		vim.wo.conceallevel = 2
	end,
}
