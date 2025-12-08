return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.comment").setup()
		require("mini.move").setup({
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "H",
				right = "L",
				down = "J",
				up = "K",
			},

			-- Options which control moving behavior
			options = {
				-- Automatically reindent selection during linewise vertical move
				reindent_linewise = true,
			},
		})
		-- require("mini.clue").setup()
		-- require("mini.pairs").setup()
		require("mini.trailspace").setup()
		-- require("mini.extra").setup()
		-- require("mini.icons").setup()
		require("mini.snippets").setup()
		require("mini.diff").setup()

		-- require("mini.indentscope").setup()
		-- require("mini.tabline").setup()
		vim.keymap.set("n", "<leader>rws", function()
			require("mini.trailspace").trim()
		end, { desc = "Erase Whitespace" })
	end,
}
