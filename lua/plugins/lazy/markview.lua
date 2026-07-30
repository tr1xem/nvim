return {
	-- "MeanderingProgrammer/render-markdown.nvim",
	"OXY2DEV/markview.nvim",
	config = function()
		require("markview").setup({
			preview = {
				icon_provider = "devicons", -- "mini" or "devicons"
			},
		})
	end,
}
