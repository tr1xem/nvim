return {
	{
		"tr1xem/leetcode.nvim", -- Some of my custom tweaks
		build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
		dependencies = {
			-- include a picker of your choice, see picker section for more details
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Leet",
		opts = {
			-- configuration goes here
			image_support = true,
			plugins = {
				non_standalone = true,
			},
		},
	},
	{

		"3rd/image.nvim",
		config = function()
			require("image").setup({})
		end,
	},
}
