return {
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			default = {
				relative_to_current_file = true,
				drag_and_drop = {
					enabled = true,
					insert_mode = true,
				},
			},
			filetypes = {
				org = {
					-- template = "[[file:$FILE_PATH][$LABEL]]",
					org = {
						template = [=[
#+BEGIN_FIGURE
[[file:$FILE_PATH]]
#+CAPTION: $CURSOR
#+NAME: fig:$LABEL
#+END_FIGURE
    ]=],
					},
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
