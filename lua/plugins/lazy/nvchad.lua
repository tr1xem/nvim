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
		event = "BufReadPre",
		opts = { -- set to setup table
		},
	},
}
