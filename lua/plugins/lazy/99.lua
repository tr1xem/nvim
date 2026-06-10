return {
	"ThePrimeagen/99",
	config = function()
		local _99 = require("99")
		_99.setup({
			show_in_flight_requests = true,
			md_files = {
				"AGENTS.md",
			},
			completion = {
				custom_rules = {
					"~/personal/skills/skills/",
				},
				source = "cmp",
			},
			model = "openai/gpt-5.3-codex",
		})
		vim.keymap.set("n", "<leader>9s", function()
			_99.search()
		end, { desc = "Search" })

		vim.keymap.set("v", "<leader>9vv", function()
			_99.visual()
		end, { desc = "Visual Search" })

		vim.keymap.set("v", "<leader>9vp", function()
			_99.visual_prompt()
		end, { desc = "Visual Prompt" })

		vim.keymap.set("n", "<leader>9x", function()
			_99.stop_all_requests()
		end, { desc = "Stop All Requests" })

		vim.keymap.set("n", "<leader>9i", function()
			_99.info()
		end, { desc = "Info" })

		vim.keymap.set("n", "<leader>9l", function()
			_99.view_logs()
		end, { desc = "View Logs" })

		vim.keymap.set("n", "<leader>9n", function()
			_99.next_request_logs()
		end, { desc = "Next Request Log" })

		vim.keymap.set("n", "<leader>9p", function()
			_99.prev_request_logs()
		end, { desc = "Previous Request Log" })
	end,
}
