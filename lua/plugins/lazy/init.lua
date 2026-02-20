return {
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"eandrju/cellular-automaton.nvim",
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},
}
