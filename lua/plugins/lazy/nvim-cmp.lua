return {
	{
		-- snippet plugin
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
		opts = { history = true, updateevents = "TextChanged,TextChangedI" },
		config = function(_, opts)
			require("luasnip").config.set_config(opts)
			-- vscode format
			require("luasnip.loaders.from_vscode").lazy_load({ exclude = vim.g.vscode_snippets_exclude or {} })
			require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

			-- snipmate format
			require("luasnip.loaders.from_snipmate").load()
			require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

			-- lua format
			require("luasnip.loaders.from_lua").load()
			require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

			-- fix luasnip #258
			vim.api.nvim_create_autocmd("InsertLeave", {
				callback = function()
					if
						require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
						and not require("luasnip").session.jump_active
					then
						require("luasnip").unlink_current()
					end
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"https://codeberg.org/FelipeLema/cmp-async-path.git",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"NvChad/ui",
		},
		config = function()
			local cmp = require("cmp")
			local confirm = function(entry)
				local behavior = cmp.ConfirmBehavior.Replace
				if entry then
					local completion_item = entry.completion_item
					local newText = ""
					if completion_item.textEdit then
						newText = completion_item.textEdit.newText
					elseif type(completion_item.insertText) == "string" and completion_item.insertText ~= "" then
						newText = completion_item.insertText
					else
						newText = completion_item.word or completion_item.label or ""
					end

					-- checks how many characters will be different after the cursor position if we replace?
					local diff_after = math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col

					-- does the text that will be replaced after the cursor match the suffix
					-- of the `newText` to be inserted ? if not, then `Insert` instead.
					if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
						behavior = cmp.ConfirmBehavior.Insert
					end
				end
				cmp.confirm({ select = true, behavior = behavior })
			end

			dofile(vim.g.base46_cache .. "cmp")
			local options = {
				completion = { completeopt = "menu,menuone" },

				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					["<C-y>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							local entry = cmp.get_selected_entry()
							confirm(entry)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(), -- close completion window

					-- ["<CR>"] = cmp.mapping.confirm({
					-- 	behavior = cmp.ConfirmBehavior.Insert,
					-- 	select = true,
					-- }),

					["<Tab>"] = cmp.mapping(function(fallback)
						-- if cmp.visible() then
						-- 	cmp.select_next_item()
						if require("luasnip").expand_or_jumpable() then
							require("luasnip").expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						-- if cmp.visible() then
						-- 	cmp.select_prev_item()
						if require("luasnip").jumpable(-1) then
							require("luasnip").jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},

				sources = {
					{ name = "neorg" },
					{ name = "async_path" },
					{ name = "nvim_lsp" },
					{ name = "supermaven" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
				},
			}
			cmp.setup(vim.tbl_deep_extend("force", options, require("nvchad.cmp")))
		end,
	},
}
