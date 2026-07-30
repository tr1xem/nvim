return {
	-- {
	-- 	"stevearc/oil.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	keymaps = {
	-- 		["<leader>p"] = function()
	-- 			local oil = require("oil")
	-- 			local filename = oil.get_cursor_entry().name
	-- 			local dir = oil.get_current_dir()
	-- 			oil.close()
	--
	-- 			local img_clip = require("img-clip")
	-- 			img_clip.paste_image({}, dir .. filename)
	-- 		end,
	-- 	},
	-- 	config = function()
	-- 		-- CustomOilBar = function()
	-- 		-- 	local path = vim.fn.expand("%")
	-- 		-- 	path = path:gsub("oil://", "")
	-- 		--
	-- 		-- 	return "  " .. vim.fn.fnamemodify(path, ":.")
	-- 		-- end
	-- 		--
	-- 		require("oil").setup({
	-- 			-- columns = { "icon" },
	-- 			keymaps = {
	-- 				["<C-h>"] = false,
	-- 				["<C-l>"] = false,
	-- 				["<C-k>"] = false,
	-- 				["<C-j>"] = false,
	-- 				-- ["<M-h>"] = "actions.select_split",
	-- 			},
	-- 			-- win_options = {
	-- 			-- winbar = "%{v:lua.CustomOilBar()}",
	-- 			-- },
	-- 			view_options = {
	-- 				show_hidden = true,
	-- 			},
	-- 		})
	--
	-- 		-- Open parent directory in current window
	-- 		-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	--
	-- 		-- Open parent directory in floating window
	-- 		vim.keymap.set("n", "-", require("oil").toggle_float, {})
	-- 	end,
	-- },
	{
		"ingur/fzf-oil.nvim",
		dependencies = {
			"ibhagwan/fzf-lua",
			"stevearc/oil.nvim",
		},
		keymaps = {
			["<leader>p"] = function()
				local oil = require("oil")
				local filename = oil.get_cursor_entry().name
				local dir = oil.get_current_dir()
				oil.close()

				local img_clip = require("img-clip")
				img_clip.paste_image({}, dir .. filename)
			end,
		},
		config = function()
			-- use fzf-oil's float helper so oil matches fzf-lua's dimensions
			require("oil").setup({
				columns = {
					"icon",
					"permissions",
					-- "size",
					-- "mtime",
				},
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
					-- ["<M-h>"] = "actions.select_split",
				},
				view_options = {
					show_hidden = true,
				},
				float = require("fzf-oil").float,
			})

			local browser = require("fzf-oil").setup()

			-- vim.keymap.set("n", "-", require("oil").toggle_float, {})
			vim.keymap.set("n", "-", browser.browse, { desc = "File browser" })
		end,
	},
}
