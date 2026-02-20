return {
	{
		"NvChad/base46",
		dependencies = {
			"NvChad/ui",
		},
		lazy = false,
		priority = 1000,
		init = function()
			vim.g.base46_cache = vim.fn.stdpath("cache") .. "/base46"
			vim.api.nvim_create_autocmd("User", {
				pattern = "NvThemeReload",
				callback = function()
					vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { underline = true })
				end,
			})
		end,
		config = function(_, opts)
			local nvconfig = require("nvconfig")
			nvconfig.base46 = vim.tbl_deep_extend("force", nvconfig.base46, opts)

			vim.fn.mkdir(vim.g.base46_cache, "p")

			require("base46").load_all_highlights()
		end,
	},
	{
		"NvChad/ui",
		config = function()
			require("nvchad")
		end,
	},
	{
		"nvzone/volt",
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")
			return { override = require("nvchad.icons.devicons") }
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "blankline")

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)

			dofile(vim.g.base46_cache .. "blankline")
		end,
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		opts = function()
			dofile(vim.g.base46_cache .. "whichkey")
			return {}
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		enabled = true,
		event = "BufReadPre",
		opts = { -- set to setup table
			filetypes = { "*" }, -- Filetype options.  Accepts table like `user_default_options`
			buftypes = {}, -- Buftype options.  Accepts table like `user_default_options`
			-- Boolean | List of usercommands to enable.  See User commands section.
			user_commands = true, -- Enable all or some usercommands
			lazy_load = true, -- Lazily schedule buffer highlighting setup function
			user_default_options = {
				names = true, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
				names_opts = { -- options for mutating/filtering names.
					lowercase = true, -- name:lower(), highlight `blue` and `red`
					camelcase = true, -- name, highlight `Blue` and `Red`
					uppercase = false, -- name:upper(), highlight `BLUE` and `RED`
					strip_digits = false, -- ignore names with digits,
					-- highlight `blue` and `red`, but not `blue3` and `red4`
				},
				-- Expects a table of color name to #RRGGBB value pairs.  # is optional
				-- Example: { cool = "#107dac", ["notcool"] = "ee9240" }
				-- Set to false to disable, for example when setting filetype options
				names_custom = false, -- Custom names to be highlighted: table|function|false
				RGB = true, -- #RGB hex codes
				RGBA = true, -- #RGBA hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = false, -- CSS rgb() and rgba() functions
				hsl_fn = false, -- CSS hsl() and hsla() functions
				oklch_fn = false, -- CSS oklch() function
				css = true, -- Enable all CSS *features*:
				-- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn, oklch_fn
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn, oklch_fn
				-- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
				tailwind = "both", -- Enable tailwind colors
				tailwind_opts = { -- Options for highlighting tailwind names
					update_names = true, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
				},
				-- parsers can contain values used in `user_default_options`
				sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
				xterm = false, -- Enable xterm 256-color codes (#xNN, \e[38;5;NNNm)
				-- Highlighting mode.  'background'|'foreground'|'virtualtext'
				mode = "virtualtext", -- Set the display mode
				-- Virtualtext character to use
				virtualtext = "󱓻",
				-- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
				virtualtext_inline = "before",
				-- Virtualtext highlight mode: 'background'|'foreground'
				virtualtext_mode = "foreground",
				-- update color values even if buffer is not focused
				-- example use: cmp_menu, cmp_docs
				always_update = false,
				-- hooks to invert control of colorizer
				hooks = {
					-- called before line parsing.  Accepts boolean or function that returns boolean
					-- see hooks section below
					disable_line_highlight = false,
				},
			},
		},
	},
}
