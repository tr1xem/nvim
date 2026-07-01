return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	init = function()
		vim.g.no_plugin_maps = true
	end,
	config = function()
		--                       _       _                                       _           _
		--   __ _  ___ _ __ ___ (_)_ __ (_)       __ _  ___ _ __   ___ _ __ __ _| |_ ___  __| |
		--  / _` |/ _ \ '_ ` _ \| | '_ \| |_____ / _` |/ _ \ '_ \ / _ \ '__/ _` | __/ _ \/ _` |
		-- | (_| |  __/ | | | | | | | | | |_____| (_| |  __/ | | |  __/ | | (_| | ||  __/ (_| |
		--  \__, |\___|_| |_| |_|_|_| |_|_|      \__, |\___|_| |_|\___|_|  \__,_|\__\___|\__,_|
		--  |___/                                |___/
		--            _                 _   _                      __   _   _                  _     _
		--  _ __ ___ (_) __ _ _ __ __ _| |_(_) ___  _ __     ___  / _| | |_| |__   ___    ___ | | __| |
		-- | '_ ` _ \| |/ _` | '__/ _` | __| |/ _ \| '_ \   / _ \| |_  | __| '_ \ / _ \  / _ \| |/ _` |
		-- | | | | | | | (_| | | | (_| | |_| | (_) | | | | | (_) |  _| | |_| | | |  __/ | (_) | | (_| |
		-- |_| |_| |_|_|\__, |_|  \__,_|\__|_|\___/|_| |_|  \___/|_|    \__|_| |_|\___|  \___/|_|\__,_|
		--              |___/
		--  _            _        _     _           _                          __ _
		-- | |_ _____  _| |_ ___ | |__ (_) ___  ___| |_ ___    ___ ___  _ __  / _(_) __ _
		-- | __/ _ \ \/ / __/ _ \| '_ \| |/ _ \/ __| __/ __|  / __/ _ \| '_ \| |_| |/ _` |
		-- | ||  __/>  <| || (_) | |_) | |  __/ (__| |_\__ \ | (_| (_) | | | |  _| | (_| |
		--  \__\___/_/\_\\__\___/|_.__// |\___|\___|\__|___/  \___\___/|_| |_|_| |_|\__, |
		--                           |__/                                           |___/

		local textobjects = require("textobjects").V2

		-- 1. Setup behavioral options (keymaps don't take effect here)
		require("nvim-treesitter-textobjects").setup(textobjects)

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")

		-- Helper to convert leading space in V2 keys to <leader>
		local function parse_key(key)
			return key:gsub("^%s", "<leader>")
		end

		-- 2. Select Mappings (Modes: Visual 'x', Operator-pending 'o')
		if textobjects.select and textobjects.select.enable and textobjects.select.keymaps then
			for key, opts in pairs(textobjects.select.keymaps) do
				vim.keymap.set({ "x", "o" }, parse_key(key), function()
					select.select_textobject(opts.query, "textobjects")
				end, { desc = opts.desc })
			end
		end

		-- 3. Move Mappings
		if textobjects.move and textobjects.move.enable then
			local move_maps = {
				goto_next_start = move.goto_next_start,
				goto_next_end = move.goto_next_end,
				goto_previous_start = move.goto_previous_start,
				goto_previous_end = move.goto_previous_end,
			}

			for map_type, func in pairs(move_maps) do
				local target_table = textobjects.move[map_type]
				-- Explicitly check for table type to satisfy LSP type-narrowing
				if type(target_table) == "table" then
					for key, opts in pairs(target_table) do
						vim.keymap.set({ "n", "x", "o" }, parse_key(key), function()
							func(opts.query, "textobjects")
						end, { desc = opts.desc })
					end
				end
			end
		end

		-- 4. Swap Mappings
		if textobjects.swap and textobjects.swap.enable then
			local swap_maps = {
				swap_next = swap.swap_next,
				swap_previous = swap.swap_previous,
			}

			for map_type, func in pairs(swap_maps) do
				local target_table = textobjects.swap[map_type]
				-- Explicitly check for table type to satisfy LSP type-narrowing
				if type(target_table) == "table" then
					for key, opts in pairs(target_table) do
						vim.keymap.set("n", parse_key(key), function()
							func(opts.query)
						end, { desc = opts.desc })
					end
				end
			end
		end
	end,
}
