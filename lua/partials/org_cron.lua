local orgmode = vim.fn.stdpath("data") .. "/lazy/orgmode"
vim.opt.runtimepath:append(orgmode)

require("orgmode").cron({
	org_agenda_files = vim.fn.expand("~/personal/orgfiles/**/*"),
	org_default_notes_file = vim.fn.expand("~/personal/orgfiles/refile.org"),
	org_todo_keywords = { "TODO", "WAITING", "PROGRESS", "|", "DONE", "DELEGATED" },
	notifications = {
		enabled = false,
		cron_enabled = true,
		repeater_reminder_time = { 10, 0 },
		deadline_warning_reminder_time = { 120, 60, 30, 0 },
		reminder_time = { 30, 10, 0 },
		deadline_reminder = true,
		scheduled_reminder = true,
		cron_notifier = function(tasks)
			for _, task in ipairs(tasks) do
				local title = string.format("%s (%s)", task.category, task.humanized_duration)
				local subtitle = string.format("%s %s %s", string.rep("*", task.level), task.todo, task.title)
				local date = string.format("%s: %s", task.type, task.time:to_string())

				if vim.fn.executable("notify-send") == 1 then
					vim.system({
						"notify-send",
						"--app-name=orgmode",
						"--icon=" .. vim.fn.stdpath("config") .. "/orgmode/nvim-orgmode-small.png",
						title,
						string.format("%s\n%s", subtitle, date),
					})
				end
			end
		end,
	},
})
