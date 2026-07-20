return {
	{
		"ej-shafran/compile-mode.nvim",
		-- you can just use the latest version:
		-- branch = "latest",
		-- or the most up-to-date updates:
		-- branch = "nightly",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- if you want to enable coloring of ANSI escape codes in
			-- compilation output, add:
			-- { "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
		config = function()
			---@type CompileModeOpts
			vim.g.compile_mode = {
				-- if you use something like `nvim-cmp` or `blink.cmp` for completion,
				-- set this to fix tab completion in command mode:
				input_word_completion = true,

				-- to add ANSI escape code support, add:
				baleia_setup = true,

				-- to make `:Compile` replace special characters (e.g. `%`) in
				-- the command (and behave more like `:!`), add:
				bang_expansion = true,
			}

			-- vim.keymap.set("n", "<leader>cmc", function()
			-- 	local args = vim.fn.input("Compile args: ")
			-- 	if args ~= "" then
			-- 		vim.cmd("below Compile " .. args)
			-- 	end
			-- end)
			vim.keymap.set("n", "<leader>cmc", function()
				local keys = vim.api.nvim_replace_termcodes(":below Compile ", true, false, true)
				vim.api.nvim_feedkeys(keys, "n", false)
			end)
			vim.keymap.set("n", "<leader>cmr", "<Cmd>:Recompile<CR>")
			vim.keymap.set("n", "<leader>cmt", "<Cmd>:CompileInterrupt<CR>")
		end,
	},

	{
		"m00qek/baleia.nvim",
		version = "*",
		config = function()
			vim.g.baleia = require("baleia").setup({})

			-- Command to colorize the current buffer
			vim.api.nvim_create_user_command("BaleiaColorize", function()
				vim.g.baleia.once(vim.api.nvim_get_current_buf())
			end, { bang = true })

			-- Command to show logs
			vim.api.nvim_create_user_command("BaleiaLogs", vim.cmd.messages, { bang = true })
		end,
	},
}
