return {
	{
		"3rd/image.nvim",
		config = function()
			require("image").setup({
				integrations = {
					org = {
						enabled = true,
					},
				},
			})
		end,
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			relative_to_current_file = true,
			filetypes = {
				org = {
					template = "[[file:$FILE_PATH][$LABEL]]",
					-- 					template = [=[
					-- #+BEGIN_FIGURE
					-- [[file:$FILE_PATH]]
					-- #+CAPTION: $CURSOR
					-- #+NAME: fig:$LABEL
					-- #+END_FIGURE
					--     ]=], ---@type string | fun(context: table): string
				},
				norg = {
					url_encode_path = true,
					template = ".image $FILE_PATH",
					download_images = false,
				},
			},
		},
		keys = {
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
}
