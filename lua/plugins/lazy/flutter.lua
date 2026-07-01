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
			fvm = true,
			dev_log = {
				enabled = true,
			},
			dev_tools = {
				autostart = true,
				auto_openbrowser = true,
			},
		})
		vim.keymap.set("n", "<leader>fr", [[:FlutterReload<CR>]], { desc = "FlutterReload" })
		vim.keymap.set("n", "<leader>fR", [[:FlutterRestart<CR>]], { desc = "FlutterRestart" })
		vim.keymap.set("n", "<leader>fd", [[:FlutterDevices<CR>]], { desc = "FlutterDevices" })
		vim.keymap.set("n", "<leader>fe", [[:FlutterEmulators<CR>]], { desc = "FlutterEmulators" })
		vim.keymap.set("n", "<leader>fl", [[:FlutterLogToggle<CR>]], { desc = "FlutterLogToggle" })
	end,
}
