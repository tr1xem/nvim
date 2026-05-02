vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
require("plugins")
require("plugins.custom.linkhelper")
require("chadrc")
dofile(vim.g.base46_cache .. "defaults")
vim.o.winborder = "single"
-- vim.o.guifont = "JetBrainsMono Nerd Font:h10"

local orgmode_clock = require("plugins.custom.orgmode_clock")
orgmode_clock.start_auto_update()

-- Experimentation
require("vim._core.ui2").enable({
	enable = true, -- Whether to enable or disable the UI.
	msg = { -- Options related to the message module.
		---@type 'cmd'|'msg' Default message target, either in the
		---cmdline or in a separate ephemeral message window.
		---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
		---or table mapping |ui-messages| kinds and triggers to a target.
		targets = "cmd",
		cmd = { -- Options related to messages in the cmdline window.
			height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
		},
		dialog = { -- Options related to dialog window.
			height = 0.5, -- Maximum height.
		},
		msg = { -- Options related to msg window.
			height = 0.5, -- Maximum height.
			timeout = 4000, -- Time a message is visible in the message window.
		},
		pager = { -- Options related to message window.
			height = 1, -- Maximum height.
		},
	},
})
