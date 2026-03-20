local M = {}

local clock_win = nil
local clock_buf = nil
local clock_timer = nil

M.create_clock_window = function(content)
	-- Only create if not already open
	if clock_win and vim.api.nvim_win_is_valid(clock_win) then
		return
	end

	-- Create buffer
	clock_buf = vim.api.nvim_create_buf(false, true)

	-- Calculate dynamic width and height based on content
	local width = 0
	local height = #content
	for _, line in ipairs(content) do
		width = math.max(width, #line + 2) -- +4 for padding
	end
	width = math.min(width, vim.o.columns - 4) -- Don't exceed screen width

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = vim.o.columns - width - 2,
		row = 1,
		style = "minimal",
		border = "rounded",
		title = " Orgmode Clock ",
	}

	clock_win = vim.api.nvim_open_win(clock_buf, false, opts)
end

M.update_clock_display = function()
	local ok, orgmode = pcall(require, "orgmode")
	if not ok then
		return
	end

	-- Get the clock status from get_statusline()
	local clock_info = orgmode.clock:get_statusline()

	-- If no clock, close the window
	if clock_info == "" or clock_info == nil then
		M.close_clock_window()
		return
	end

	local content = {
		" " .. clock_info,
	}

	M.create_clock_window(content)

	vim.api.nvim_buf_set_lines(clock_buf, 0, -1, false, content)
end

M.close_clock_window = function()
	if clock_win and vim.api.nvim_win_is_valid(clock_win) then
		vim.api.nvim_win_close(clock_win, true)
		clock_win = nil
	end
	if clock_buf and vim.api.nvim_buf_is_valid(clock_buf) then
		vim.api.nvim_buf_delete(clock_buf, { force = true })
		clock_buf = nil
	end
end

-- Start the auto-update timer
M.start_auto_update = function()
	if clock_timer then
		vim.fn.timer_stop(clock_timer)
	end
	clock_timer = vim.fn.timer_start(1000, function()
		M.update_clock_display()
	end, { ["repeat"] = -1 })
end

M.stop_auto_update = function()
	if clock_timer then
		vim.fn.timer_stop(clock_timer)
		clock_timer = nil
	end
end

return M
