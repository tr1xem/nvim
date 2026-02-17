pcall(function()
	dofile(vim.g.base46_cache .. "syntax")
	dofile(vim.g.base46_cache .. "treesitter")
end)
local V1 = {
	enable = true,
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["if"] = { query = "@function.inner", desc = "function" },
			["ic"] = { query = "@class.inner", desc = "class" },
			["io"] = { query = "@loop.inner", desc = "loop" },
			["ik"] = { query = "@block.inner", desc = "block" },
			["ii"] = { query = "@conditional.inner", desc = "conditional" },
			["ie"] = { query = "@statement.outer", desc = "statement" },
			["ir"] = { query = "@parameter.inner", desc = "parameter" },
			["ig"] = { query = "@assignment.inner", desc = "assignment" },
			["iu"] = { query = "@return.inner", desc = "return" },
			["i1"] = { query = "@call.inner", desc = "call" },
			["i2"] = { query = "@comment.inner", desc = "comment" },

			["af"] = { query = "@function.outer", desc = "function" },
			["ac"] = { query = "@class.outer", desc = "class" },
			["ao"] = { query = "@loop.outer", desc = "loop" },
			["ak"] = { query = "@block.outer", desc = "block" },
			["ai"] = { query = "@conditional.outer", desc = "conditional" },
			["ae"] = { query = "@statement.outer", desc = "statement" },
			["ar"] = { query = "@parameter.outer", desc = "parameter" },
			["ag"] = { query = "@assignment.outer", desc = "assignment" },
			["au"] = { query = "@return.outer", desc = "return" },
			["a1"] = { query = "@call.outer", desc = "call" },
			["a2"] = { query = "@comment.outer", desc = "comment" },

			["in"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["iN"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
	},
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
			["]f"] = { query = "@function.outer", desc = "function" },
			["]c"] = { query = "@class.outer", desc = "class" },
			["]o"] = { query = "@loop.outer", desc = "loop" },
			["]k"] = { query = "@block.outer", desc = "block" },
			["]i"] = { query = "@conditional.outer", desc = "conditional" },
			["]e"] = { query = "@statement.outer", desc = "statement" },
			["]r"] = { query = "@parameter.outer", desc = "parameter" },
			["]g"] = { query = "@assignment.outer", desc = "assignment" },
			["]u"] = { query = "@return.outer", desc = "return" },
			["]1"] = { query = "@call.outer", desc = "call" },
			["]2"] = { query = "@comment.outer", desc = "comment" },

			["]n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["]N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		goto_next_end = {
			["]F"] = { query = "@function.outer", desc = "function" },
			["]C"] = { query = "@class.outer", desc = "class" },
			["]O"] = { query = "@loop.outer", desc = "loop" },
			["]K"] = { query = "@block.outer", desc = "block" },
			["]I"] = { query = "@conditional.outer", desc = "conditional" },
			["]E"] = { query = "@statement.outer", desc = "statement" },
			["]R"] = { query = "@parameter.outer", desc = "parameter" },
			["]G"] = { query = "@assignment.outer", desc = "assignment" },
			["]U"] = { query = "@return.outer", desc = "return" },
			["]!"] = { query = "@call.outer", desc = "call" },
			["]@"] = { query = "@comment.outer", desc = "comment" },
		},
		goto_previous_start = {
			["[f"] = { query = "@function.outer", desc = "function" },
			["[c"] = { query = "@class.outer", desc = "class" },
			["[o"] = { query = "@loop.outer", desc = "loop" },
			["[k"] = { query = "@block.outer", desc = "block" },
			["[i"] = { query = "@conditional.outer", desc = "conditional" },
			["[e"] = { query = "@statement.outer", desc = "statement" },
			["[r"] = { query = "@parameter.outer", desc = "parameter" },
			["[g"] = { query = "@assignment.outer", desc = "assignment" },
			["[u"] = { query = "@return.outer", desc = "return" },
			["[1"] = { query = "@call.outer", desc = "call" },
			["[2"] = { query = "@comment.outer", desc = "comment" },

			["[n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["[N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		goto_previous_end = {
			["[F"] = { query = "@function.outer", desc = "function" },
			["[C"] = { query = "@class.outer", desc = "class" },
			["[O"] = { query = "@loop.outer", desc = "loop" },
			["[K"] = { query = "@block.outer", desc = "block" },
			["[I"] = { query = "@conditional.outer", desc = "conditional" },
			["[E"] = { query = "@statement.outer", desc = "statement" },
			["[R"] = { query = "@parameter.outer", desc = "parameter" },
			["[G"] = { query = "@assignment.outer", desc = "assignment" },
			["[U"] = { query = "@return.outer", desc = "return" },
			["[!"] = { query = "@call.outer", desc = "call" },
			["[@"] = { query = "@comment.outer", desc = "comment" },
		},
	},
	swap = { -- FIXME: a lot of mappings here don't work, a lot of mappings overlap with native ones:
		enable = true,
		swap_next = {
			[">f"] = { query = "@function.outer", desc = "function" },
			[">c"] = { query = "@class.outer", desc = "class" },
			[">o"] = { query = "@loop.outer", desc = "loop" },
			[">k"] = { query = "@block.outer", desc = "block" },
			[">i"] = { query = "@conditional.outer", desc = "conditional" },
			[">e"] = { query = "@statement.outer", desc = "statement" },
			[">r"] = { query = "@parameter.inner", desc = "parameter" },
			[">g"] = { query = "@assignment.outer", desc = "assignment" },
			[">u"] = { query = "@return.outer", desc = "return" },
			[">1"] = { query = "@call.outer", desc = "call" },
			[">2"] = { query = "@comment.outer", desc = "comment" },

			[">n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[">N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		swap_previous = {
			["<f"] = { query = "@function.outer", desc = "function" },
			["<c"] = { query = "@class.outer", desc = "class" },
			["<o"] = { query = "@loop.outer", desc = "loop" },
			["<k"] = { query = "@block.outer", desc = "block" },
			["<i"] = { query = "@conditional.outer", desc = "conditional" },
			["<e"] = { query = "@statement.outer", desc = "statement" },
			["<r"] = { query = "@parameter.inner", desc = "parameter" },
			["<g"] = { query = "@assignment.outer", desc = "assignment" },
			["<u"] = { query = "@return.outer", desc = "return" },
			["<1"] = { query = "@call.outer", desc = "call" },
			["<2"] = { query = "@comment.outer", desc = "comment" },

			["<n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["<N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
	},
}

-- f - function
-- c - class
-- l - loop
-- b - block
-- o - conditional
-- s - statement
-- p - parameter
-- r - return
-- a - call
-- m - comment

local V2 = {
	enable = true,
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["If"] = { query = "@function.inner", desc = "function" },
			["Ic"] = { query = "@class.inner", desc = "class" },
			["Io"] = { query = "@loop.inner", desc = "loop" },
			["Ik"] = { query = "@block.inner", desc = "block" },
			["Ii"] = { query = "@conditional.inner", desc = "conditional" },
			["Ie"] = { query = "@statement.outer", desc = "statement" },
			["Ir"] = { query = "@parameter.inner", desc = "parameter" },
			["Ig"] = { query = "@assignment.inner", desc = "assignment" },
			["Iu"] = { query = "@return.inner", desc = "return" },
			["I1"] = { query = "@call.inner", desc = "call" },
			["I2"] = { query = "@comment.inner", desc = "comment" },

			["Af"] = { query = "@function.outer", desc = "function" },
			["Ac"] = { query = "@class.outer", desc = "class" },
			["Ao"] = { query = "@loop.outer", desc = "loop" },
			["Ak"] = { query = "@block.outer", desc = "block" },
			["Ai"] = { query = "@conditional.outer", desc = "conditional" },
			["Ae"] = { query = "@statement.outer", desc = "statement" },
			["Ar"] = { query = "@parameter.outer", desc = "parameter" },
			["Ag"] = { query = "@assignment.outer", desc = "assignment" },
			["Au"] = { query = "@return.outer", desc = "return" },
			["A1"] = { query = "@call.outer", desc = "call" },
			["A2"] = { query = "@comment.outer", desc = "comment" },

			["In"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["IN"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
	},
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
			[" ]f"] = { query = "@function.outer", desc = "function" },
			[" ]c"] = { query = "@class.outer", desc = "class" },
			[" ]o"] = { query = "@loop.outer", desc = "loop" },
			[" ]k"] = { query = "@block.outer", desc = "block" },
			[" ]i"] = { query = "@conditional.outer", desc = "conditional" },
			[" ]e"] = { query = "@statement.outer", desc = "statement" },
			[" ]r"] = { query = "@parameter.outer", desc = "parameter" },
			[" ]g"] = { query = "@assignment.outer", desc = "assignment" },
			[" ]u"] = { query = "@return.outer", desc = "return" },
			[" ]1"] = { query = "@call.outer", desc = "call" },
			[" ]2"] = { query = "@comment.outer", desc = "comment" },

			[" ]n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[" ]N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		goto_next_end = {
			[" ]F"] = { query = "@function.outer", desc = "function" },
			[" ]C"] = { query = "@class.outer", desc = "class" },
			[" ]O"] = { query = "@loop.outer", desc = "loop" },
			[" ]K"] = { query = "@block.outer", desc = "block" },
			[" ]I"] = { query = "@conditional.outer", desc = "conditional" },
			[" ]E"] = { query = "@statement.outer", desc = "statement" },
			[" ]R"] = { query = "@parameter.outer", desc = "parameter" },
			[" ]G"] = { query = "@assignment.outer", desc = "assignment" },
			[" ]U"] = { query = "@return.outer", desc = "return" },
			[" ]!"] = { query = "@call.outer", desc = "call" },
			[" ]@"] = { query = "@comment.outer", desc = "comment" },
		},
		goto_previous_start = {
			[" [f"] = { query = "@function.outer", desc = "function" },
			[" [c"] = { query = "@class.outer", desc = "class" },
			[" [o"] = { query = "@loop.outer", desc = "loop" },
			[" [k"] = { query = "@block.outer", desc = "block" },
			[" [i"] = { query = "@conditional.outer", desc = "conditional" },
			[" [e"] = { query = "@statement.outer", desc = "statement" },
			[" [r"] = { query = "@parameter.outer", desc = "parameter" },
			[" [g"] = { query = "@assignment.outer", desc = "assignment" },
			[" [u"] = { query = "@return.outer", desc = "return" },
			[" [1"] = { query = "@call.outer", desc = "call" },
			[" [2"] = { query = "@comment.outer", desc = "comment" },

			[" [n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[" [N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		goto_previous_end = {
			[" [F"] = { query = "@function.outer", desc = "function" },
			[" [C"] = { query = "@class.outer", desc = "class" },
			[" [O"] = { query = "@loop.outer", desc = "loop" },
			[" [K"] = { query = "@block.outer", desc = "block" },
			[" [I"] = { query = "@conditional.outer", desc = "conditional" },
			[" [E"] = { query = "@statement.outer", desc = "statement" },
			[" [R"] = { query = "@parameter.outer", desc = "parameter" },
			[" [G"] = { query = "@assignment.outer", desc = "assignment" },
			[" [U"] = { query = "@return.outer", desc = "return" },
			[" [!"] = { query = "@call.outer", desc = "call" },
			[" [@"] = { query = "@comment.outer", desc = "comment" },
		},
	},
	swap = { -- FIXME: a lot of mappings here don't work
		enable = true,
		swap_next = {
			[" >f"] = { query = "@function.outer", desc = "function" },
			[" >c"] = { query = "@class.outer", desc = "class" },
			[" >o"] = { query = "@loop.outer", desc = "loop" },
			[" >k"] = { query = "@block.outer", desc = "block" },
			[" >i"] = { query = "@conditional.outer", desc = "conditional" },
			[" >e"] = { query = "@statement.outer", desc = "statement" },
			[" >r"] = { query = "@parameter.inner", desc = "parameter" },
			[" >g"] = { query = "@assignment.outer", desc = "assignment" },
			[" >u"] = { query = "@return.outer", desc = "return" },
			[" >1"] = { query = "@call.outer", desc = "call" },
			[" >2"] = { query = "@comment.outer", desc = "comment" },

			[" >n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[" >N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		swap_previous = {
			[" <f"] = { query = "@function.outer", desc = "function" },
			[" <c"] = { query = "@class.outer", desc = "class" },
			[" <o"] = { query = "@loop.outer", desc = "loop" },
			[" <k"] = { query = "@block.outer", desc = "block" },
			[" <i"] = { query = "@conditional.outer", desc = "conditional" },
			[" <e"] = { query = "@statement.outer", desc = "statement" },
			[" <r"] = { query = "@parameter.inner", desc = "parameter" },
			[" <g"] = { query = "@assignment.outer", desc = "assignment" },
			[" <u"] = { query = "@return.outer", desc = "return" },
			[" <1"] = { query = "@call.outer", desc = "call" },
			[" <2"] = { query = "@comment.outer", desc = "comment" },

			[" <n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[" <N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
	},
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-refactor",
			-- "nvim-treesitter/nvim-treesitter-context",
		},
		build = ":TSUpdate",
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				highlight = {
					enable = true,
				},
				-- enable indentation
				indent = { enable = true },

				-- enable textobjects
				textobjects = V2,

				-- ensure these languages parsers are installed
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"go",
					"yaml",
					"html",
					"css",
					"python",
					"http",
					"prisma",
					"markdown",
					"markdown_inline",
					"svelte",
					"graphql",
					"bash",
					"lua",
					"vim",
					"dockerfile",
					"gitignore",
					"query",
					"vimdoc",
					"c",
					"java",
					"rust",
					"ron",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
					},
				},
				additional_vim_regex_highlighting = true,
			})
		end,
	},
	-- NOTE: js,ts,jsx,tsx Auto Close Tags
	{
		"windwp/nvim-ts-autotag",
		enabled = true,
		ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
		config = function()
			-- Independent nvim-ts-autotag setup
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto-close tags
					enable_rename = true, -- Auto-rename pairs
					enable_close_on_slash = false, -- Disable auto-close on trailing `</`
				},
				per_filetype = {
					["html"] = {
						enable_close = true, -- Disable auto-closing for HTML
					},
					["typescriptreact"] = {
						enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
					},
				},
			})
		end,
	},
}
