function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		lazy = false,
		config = function()
			require("gruvbox").setup({
				style = "moon",
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false, -- Load immediately
		priority = 1000, -- High priority to load theme first
		config = function()
			require("tokyonight").setup({
				integrations = {
					blink_cmp = true,
				},
				style = "storm", -- Choose from `storm`, `moon`, `night`, or `day`
				transparent = true, -- Disable background color for transparency
				terminal_colors = true, -- Enable terminal colors
				styles = {
					comments = { italic = true },
					keywords = { italic = true, bold = true },
					functions = { bold = true },
					variables = {},
					sidebars = "transparent", -- Make sidebars transparent
					floats = "transparent", -- Make floating windows transparent
				},
				hide_inactive_statusline = true, -- Dim inactive status lines
				dim_inactive = true, -- Dim inactive windows
				lualine_bold = true, -- Make lualine section headers bold
			})

			-- Apply the colorscheme
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				integrations = {
					blink_cmp = true,
				},
				options = {
					transparent = true,
					terminal_colors = true,
					styles = {
						comments = "italic",
						keywords = "bold",
						functions = "italic,bold",
						variables = "italic",
					},
				},
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = { "italic", "bold" },
					keywords = { "bold" },
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				color_overrides = {},
				default_integrations = true,
				integrations = {
					cmp = true,
					blink_cmp = true,
					gitsigns = true,
					nvimtree = true,
					fzf = true,
					treesitter = true,
					notify = true,
					mason = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
							ok = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
							ok = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
					harpoon = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
				custom_highlights = {
					BlinkCmpMenuBorder = { fg = "#FFFFFF" },
					BlinkCmpDocBorder = { fg = "#89b4fa" },
				},
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
