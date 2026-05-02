return {
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
						local luasnip = require("luasnip")

						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif not luasnip.in_snippet() then
							-- Only call fallback (accept Supermaven) if NOT in a snippet
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
					{ name = "nvim_lsp", priority = 100 },
					{ name = "luasnip", priority = 90 },
					{ name = "orgmode", priority = 80 },
					{ name = "org_roam", priority = 75 },
					-- { name = "neorg", priority = 70 },
					{ name = "nvim_lua", priority = 85 },
					{ name = "async_path", priority = 60 },
					{ name = "buffer", priority = 40 },
					-- { name = "supermaven", priority = 95 },
				},
			}
			cmp.setup(vim.tbl_deep_extend("force", options, require("nvchad.cmp")))
		end,
	},
}
