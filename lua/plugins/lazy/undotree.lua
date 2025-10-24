return {
	"mbbill/undotree",
	dependencies = {
		"kevinhwang91/nvim-fundo",
		"kevinhwang91/promise-async",
	},

	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		vim.o.undofile = true
		require("fundo").setup()
	end,
}
