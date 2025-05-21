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
				default = { "path", "snippets", "lazydev", "lsp", "buffer" },
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
						padding = { 2, 1 }, -- padding only on right side
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
						columns = {
							{ "label" },
							{ "kind_icon", "kind" },
						},
					},
				},
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},
			signature = { enabled = true },
			opts_extend = { "sources.default" },
		},
	},
}
