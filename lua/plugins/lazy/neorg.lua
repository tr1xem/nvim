return {
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.keybinds"] = {
						config = {
							default_keybinds = true,
						},
					},
					["core.concealer"] = {
						config = {
							icon_preset = "diamond",
						},
					},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/dotfiles/personal/personal/neorg/",
								cpp = "~/dotfiles/personal/personal/Notes/C++/",
								code = "~/dotfiles/personal/personal/Notes/",
							},
							default_workspace = "notes",
						},
					},
					["core.export"] = {},
					["core.summary"] = {},
					["core.text-objects"] = {},
				},
			})
			vim.keymap.set("i", "<C-CR>", "<Plug>(neorg.itero.next-iteration)", {})

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			relative_to_current_file = true,
			filetypes = {
				markdown = {
					url_encode_path = true, ---@type boolean | fun(): boolean
					template = "![$CURSOR]($FILE_PATH)", ---@type string | fun(context: table): string
					download_images = false, ---@type boolean | fun(): boolean
				},

				vimwiki = {
					url_encode_path = true, ---@type boolean | fun(): boolean
					template = "![$CURSOR]($FILE_PATH)", ---@type string | fun(context: table): string
					download_images = false, ---@type boolean | fun(): boolean
				},

				html = {
					template = '<img src="$FILE_PATH" alt="$CURSOR">', ---@type string | fun(context: table): string
				},

				tex = {
					relative_template_path = false, ---@type boolean | fun(): boolean
					template = [[
\begin{figure}[h]
  \centering
  \includegraphics[width=0.8\textwidth]{$FILE_PATH}
  \caption{$CURSOR}
  \label{fig:$LABEL}
\end{figure}
    ]], ---@type string | fun(context: table): string

					formats = { "jpeg", "jpg", "png", "pdf" }, ---@type table
				},

				typst = {
					template = [[
#figure(
  image("$FILE_PATH", width: 80%),
  caption: [$CURSOR],
) <fig-$LABEL>
    ]], ---@type string | fun(context: table): string
				},

				rst = {
					template = [[
.. image:: $FILE_PATH
   :alt: $CURSOR
   :width: 80%
    ]], ---@type string | fun(context: table): string
				},

				asciidoc = {
					template = 'image::$FILE_PATH[width=80%, alt="$CURSOR"]', ---@type string | fun(context: table): string
				},

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
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
}
