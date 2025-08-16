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
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
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
			completion = {
				menu = {
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- combined together in label by colorful-menu.nvim.
						columns = { { "kind_icon" }, { "label", "kind", gap = 3 } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
			},
			signature = { enabled = true },
		},
	},
}
