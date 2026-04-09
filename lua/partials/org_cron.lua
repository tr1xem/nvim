local orgmode = vim.fn.stdpath("data") .. "/lazy/orgmode"
vim.opt.runtimepath:append(orgmode)
local home = os.getenv("HOME")

require("orgmode").cron({
	org_agenda_files = home .. "/personal/orgfiles/**/*",
	org_default_notes_file = home .. "/personal/orgfiles/todos.org",
	notifications = {
		repeater_reminder_time = { 10, 0 },
		deadline_warning_reminder_time = { 120, 60, 30, 0 },
		reminder_time = { 60, 30, 10, 0 },
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

-- Add this to crontab -l
-- * * * * * DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /usr/sbin/nvim -u NONE --noplugin --headless -c 'lua require("partials.org_cron")'
