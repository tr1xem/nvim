return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			setopt = true,
			segments = {
				{
					text = { "%s" },
					click = "v:lua.ScSa",
					condition = { builtin.not_empty },
				},
				{
					text = {
						builtin.foldfunc,
					},
					condition = { true, builtin.not_empty },
					click = "v:lua.ScFa",
				},
				{
					text = { builtin.lnumfunc, " " },
					condition = { true, builtin.not_empty },
					click = "v:lua.ScLa",
				},
				clickhandlers = { -- builtin click handlers, keys are pattern matched
					Lnum = builtin.lnum_click,
					FoldClose = builtin.foldclose_click,
					FoldOpen = builtin.foldopen_click,
					FoldOther = builtin.foldother_click,
					DapBreakpointRejected = builtin.toggle_breakpoint,
					DapBreakpoint = builtin.toggle_breakpoint,
					DapBreakpointCondition = builtin.toggle_breakpoint,
					["diagnostic/signs"] = builtin.diagnostic_click,
					gitsigns = builtin.gitsigns_click,
				},
			},
		})
	end,
}
