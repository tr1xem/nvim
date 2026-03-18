return {
	{
		"nvim-orgmode/orgmode",
		dependencies = {
			"akinsho/org-bullets.nvim",
			"danilshvalov/org-modern.nvim",
			"hamidi-dev/org-list.nvim",
			"hugginsio/org-virtual-clocktime.nvim",
		},
		event = "VeryLazy",
		config = function()
			-- Setup orgmode
			local Menu = require("org-modern.menu")
			require("orgmode").setup({
				org_agenda_files = "~/personal/orgfiles/**/*",
				org_default_notes_file = "~/personal/orgfiles/refile.org",
				org_hide_emphasis_markers = true,
				org_agenda_text_search_extra_files = { "agenda-archives" },
				org_agenda_time_grid = {
					type = { "daily", "today", "require-timed", "remove-match" },
				},

				org_startup_indented = true,
				org_log_into_drawer = "LOGBOOK",
				org_todo_keywords = { "TODO", "WAITING", "PROGRESS", "|", "DONE", "DELEGATED" },
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
					j = {
						description = "Journal",
						template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
						target = "~/personal/orgfiles/journal.org",
					},
					e = {
						description = "Event",
						subtemplates = {
							r = {
								description = "recurring",
								template = "** %?\n %T",
								target = "~/personal/orgfiles/calendar.org",
								headline = "recurring",
							},
							o = {
								description = "one-time",
								template = "** %?\n %T",
								target = "~/personal/orgfiles/calendar.org",
								headline = "one-time",
							},
						},
					},
				},
				notifications = {
					enabled = true,
					cron_enabled = false,
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
					key = "<leader>lt", -- nvim-orgmode users: you might want to change this to <leader>olt
					desc = "Toggle: Cycle through list types",
				},
				checkbox_toggle = {
					enabled = true,
					-- NOTE: for nvim-orgmode users, you should change the following mapping OR change the one from orgmode.
					-- If both mapping stay the same, the one from nvim-orgmode will "win"
					key = "<M-Space>",
					desc = "Toggle checkbox state",
					filetypes = { "org", "markdown" }, -- Add more filetypes as needed
				},
			})
			-- Experimental LSP support
			vim.lsp.enable("org")
		end,
	},
}
