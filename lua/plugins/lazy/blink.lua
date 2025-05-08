return {
	-- add blink.compat
	{
		"saghen/blink.compat",
		-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
		version = "*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		opts = {
			keymap = {
				preset = "default",
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			sources = {
				-- default = { "avante", "path", "snippets", "lsp", "buffer" },
				default = { "lazydev", "path", "snippets", "lsp", "buffer" },
				providers = {
					path = { score_offset = 100 },
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					lsp = { score_offset = 90 },
					snippets = { score_offset = 70 },
					buffer = { score_offset = 10 }, -- Lower priority
					-- avante = {
					-- 	module = "blink-cmp-avante",
					-- 	name = "Avante",
					-- 	score_offset = 100,
					-- 	opts = {
					-- 		-- options for blink-cmp-avante
					-- 	},
					-- },
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		completion = {
			menu = {
				enable = true,
				draw = {
					-- We don't need label_description now because label and label_description are already
					-- combined together in label by colorful-menu.nvim.
					treesitter = { "lsp" },
					-- columns = { { "kind_icon", "kind" }, { "label", gap = 1 } },
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
					components = {
						label = {
							width = { fill = true, max = 60 },
							text = function(ctx)
								local highlights_info = require("colorful-menu").blink_highlights(ctx)
								if highlights_info ~= nil then
									-- Or you want to add more item to label
									return highlights_info.label
								else
									return ctx.label
								end
							end,
							highlight = function(ctx)
								local highlights = {}
								local highlights_info = require("colorful-menu").blink_highlights(ctx)
								if highlights_info ~= nil then
									highlights = highlights_info.highlights
								end
								for _, idx in ipairs(ctx.label_matched_indices) do
									table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
								end
								-- Do something else
								return highlights
							end,
						},
					},
				},
			},
		},
		signature = { enabled = true },
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		opts_extend = { "sources.default" },
	},
}
