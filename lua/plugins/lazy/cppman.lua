return {
	"madskjeldgaard/cppman.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local cppman = require("cppman")
		cppman.setup()
		vim.keymap.set("n", "<leader>cm", function()
			cppman.open_cppman_for(vim.fn.expand("<cWORD>"))
		end, { desc = "Open CPP man page for word under cursor" })
		vim.keymap.set("n", "<leader>cc", function()
			cppman.input()
		end, { desc = "Open CPP man search box" })
	end,
}
