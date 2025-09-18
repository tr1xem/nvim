require("plugins")
vim.o.guifont = "JetBrainsMono Nerd Font:h10"
vim.o.winborder = "single"
-- linktitle.lua
local function fetch_title(url, callback)
	vim.fn.jobstart({ "curl", "-sL", url }, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if not data then
				return
			end
			local html = table.concat(data, "\n")
			local title = html:match("<title>(.-)</title>")
			if title then
				title = title:gsub("^%s+", ""):gsub("%s+$", "")
			else
				title = "Untitled"
			end
			callback(title)
		end,
	})
end

local function convert_link()
	-- Save buffer + line number where command was triggered
	local bufnr = vim.api.nvim_get_current_buf()
	local lnum = vim.api.nvim_win_get_cursor(0)[1]

	local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1]

	-- Try to match Markdown link first
	local before, text, url, after = line:match("^(.-)%[(.-)%]%((https?://[^%s)]+)%)()")

	if not url then
		-- fallback: raw URL under cursor
		url = vim.fn.expand("<cWORD>")
		if not url:match("^https?://") then
			print("No valid URL found")
			return
		end
		text = ""
		before, after = line:sub(1, vim.fn.col(".") - 1), line:sub(vim.fn.col("."))
	end

	fetch_title(url, function(title)
		local newtext = string.format("[%s](%s)", title, url)
		local newline
		if before and after then
			newline = before .. newtext .. line:sub(after)
		else
			newline = newtext
		end

		vim.schedule(function()
			-- replace the *same line* where it was triggered
			vim.api.nvim_buf_set_lines(bufnr, lnum - 1, lnum, false, { newline })
		end)
	end)
end

vim.keymap.set("n", "<leader>gt", convert_link, { silent = true, desc = "Convert URL to [title](url)" })
