local home = os.getenv("HOME")
return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	config = function()
		require("flutter-tools").setup({
			dev_log = {
				enabled = true,
			},
			dev_tools = {
				autostart = true,
				auto_openbrowser = true,
			},
		})
		vim.keymap.set("n", "Fr", [[:FlutterReload<CR>]], {})
		vim.keymap.set("n", "FR", [[:FlutterRestart<CR>]], {})
	end,
}
