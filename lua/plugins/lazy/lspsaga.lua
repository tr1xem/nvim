return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	config = function()
		require("lspsaga").setup({

			lightbulb = {
				enable = false,
				sign = false,
				virtual_text = true,
			},
		})
		vim.keymap.set("n", "[E", function()
			require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end)
	end,
}
