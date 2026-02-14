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
			require("notify").setup()
			vim.notify = require("notify")
		end,
	},
}
