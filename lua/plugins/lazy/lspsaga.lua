return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	config = function()
		require("lspsaga").setup({

			hover = {
				open_cmd = "!zen-browser",
			},
			lightbulb = {
				enable = false,
				sign = false,
				virtual_text = true,
			},
			code_action = {
				keys = {
					quit = { "q", "<ESC>" },
				},
			},
			finder = {
				keys = {
					quit = { "q", "<ESC>" },
				},
			},
		})
	end,
}
