local org_path = function(path)
	local org_directory = "~/personal/orgfiles"
	return ("%s/%s"):format(org_directory, path)
end

return {
	{
		"nvim-orgmode/orgmode",
		dependencies = {
			"akinsho/org-bullets.nvim",
			"danilshvalov/org-modern.nvim",
			"hamidi-dev/org-list.nvim",
			"hugginsio/org-virtual-clocktime.nvim",
			"sudo-burger/cmp-org-roam",
		},
		event = "VeryLazy",
		config = function()
			-- Setup orgmode
			local Menu = require("org-modern.menu")
			require("orgmode").setup({
				org_agenda_files = { org_path("**/*"), ("%s/*.org"):format(vim.fn.getcwd()) },
				org_default_notes_file = org_path("refile.org"),
				org_agenda_min_height = 24,
				org_agenda_text_search_extra_files = { "agenda-archives" },
				org_hide_emphasis_markers = true,
				org_highlight_latex_and_related = "native",
				org_agenda_time_grid = {
					type = { "daily", "today", "require-timed", "remove-match" },
				},

				org_startup_indented = true,
				org_log_into_drawer = "LOGBOOK",
				org_todo_keywords = { "TODO(t)", "WAITING(w)", "PROGRESS(p)", "|", "DONE(d)", "DELEGATED(l)" },
				org_todo_keyword_faces = {
					TODO = ":foreground #FF5555 :weight bold",
					WAITING = ":foreground #BD93F9 :weight bold",
					PROGRESS = ":foreground #FFAA00 :weight bold",
					DONE = ":foreground #50FA7B :weight bold",
					DELEGATED = ":foreground #98cbfa :slant italic :underline on",
				},
				ui = {
					input = {
						use_vim_ui = true,
					},
					menu = {
						handler = function(data)
							Menu:new({
								window = {
									margin = { 1, 0, 1, 0 },
									padding = { 0, 1, 0, 1 },
									title_pos = "center",
									border = "single",
									zindex = 1000,
								},
								icons = {
									separator = "➜",
								},
							}):open(data)
						end,
					},
				},
				org_capture_templates = {
					t = {
						template = "* TODO %?\nDEADLINE: %T",
						target = org_path("todos.org"),
						datetree = {
							tree_type = "custom",
							tree = {
								{
									format = "%Y",
									pattern = "^(%d%d%d%d)$",
									order = { 1 },
								},
								{
									format = "%B",
									pattern = "^(%a+)$",
									order = { 1 },
								},
								{
									format = "%d-%m-%Y %A",
									pattern = "^(%d%d)%-(%d%d)%-(%d%d%d%d) (%a+)$",
									order = { 3, 2, 1, 4 },
								},
							},
						},
					},
					j = {
						description = "Journal",
						template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
						target = org_path("journal/%<%Y-%m>.org"),
					},
					e = {
						description = "Event",
						subtemplates = {
							r = {
								description = "recurring",
								template = "** %?\n %T",
								target = org_path("calendar.org"),
								headline = "recurring",
							},
							o = {
								description = "one-time",
								template = "** %?\n %T",
								target = org_path("calendar.org"),
								headline = "one-time",
							},
						},
					},
					r = {
						description = "Refile",
						subtemplates = {
							t = {
								description = "Things to lookat",
								headline = "Things to look at",
								target = org_path("refile.org"),
								template = "* %? \n %u",
							},
							i = {
								description = "Idea",
								headline = "Ideas",
								target = org_path("refile.org"),
								template = "* %? \n %u",
							},
							g = {
								description = "Games",
								headline = "Games to play",
								target = org_path("refile.org"),
								template = "- [ ] %?",
							},
							m = {
								description = "Movies",
								headline = "Movies to watch",
								target = org_path("refile.org"),
								template = "- [ ] %?",
							},
						},
					},
				},
				mapping = {
					org_toggle_checkbox = "<M-Space>",
				},
				notifications = {
					enabled = true,
					repeater_reminder_time = { 10, 0 },
					deadline_warning_reminder_time = { 120, 60, 30 },
					reminder_time = { 30, 10, 0 },
					deadline_reminder = true,
					scheduled_reminder = true,
					notifier = function(tasks)
						for _, task in ipairs(tasks) do
							local title = string.format("%s (%s)", task.category, task.humanized_duration)
							local message = string.format(
								"%s %s %s\n%s: %s",
								string.rep("*", task.level),
								task.todo,
								task.title,
								task.type,
								task.time:to_string()
							)

							vim.notify(message, vim.log.levels.INFO, {
								title = title,
								timeout = 5000,
							})
						end
					end,
				},
			})
			require("org-bullets").setup()
			require("org-list").setup({
				mapping = {
					key = "<leader>olt",
					desc = "Toggle: Cycle through list types",
				},
				checkbox_toggle = {
					enabled = true,
					-- NOTE: for nvim-orgmode users, you should change the following mapping OR change the one from orgmode.
					-- If both mapping stay the same, the one from nvim-orgmode will "win"
					key = "<M-Space>",
					desc = "Toggle checkbox state",
					filetypes = { "org", "markdown" },
				},
			})
			-- Experimental LSP support
			vim.lsp.enable("org")
			-- Refile
			vim.api.nvim_create_autocmd({ "User", "BufEnter" }, {
				pattern = { "NvchadThemeLoaded", "*.org" },
				callback = function()
					vim.api.nvim_set_hl(0, "@org.keyword.done", { fg = "#2ac3de" })
				end,
			})
			-- Agenda View
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "orgagenda",
				callback = function()
					vim.schedule(function()
						vim.api.nvim_set_hl(0, "@org.agenda.scheduled", { fg = "#ff9e64" })
						vim.api.nvim_set_hl(0, "@org.agenda.day", { fg = "#b292eb" })
						vim.api.nvim_set_hl(0, "@org.agenda.deadline", { fg = "#d94a49" })
						vim.api.nvim_set_hl(0, "@org.agenda.time_grid", { fg = "#28a8c2" })
					end)
				end,
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "org",
				callback = function()
					vim.keymap.set(
						"i",
						"<S-CR>",
						'<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>',
						{
							silent = true,
							buffer = true,
						}
					)
				end,
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "org", "orgagenda" },
				callback = function()
					vim.opt_local.wrap = true
					vim.opt_local.linebreak = true
				end,
			})
		end,
	},
	{

		"chipsenkbeil/org-roam.nvim",
		config = function()
			require("org-roam").setup({
				directory = "~/personal/orgfiles/roam",
				org_files = {
					"~/personal/orgfiles/",
					"~/personal/orgfiles/refile.org",
				},
			})
			vim.keymap.set("n", "<CR>", function()
				require("org-roam").open_node()
			end, { buffer = true })
		end,
	},
}
