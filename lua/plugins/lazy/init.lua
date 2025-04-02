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
		end,
	},
}
