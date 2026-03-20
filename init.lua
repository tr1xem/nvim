vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
require("plugins")
require("plugins.custom.linkhelper")
require("chadrc")
dofile(vim.g.base46_cache .. "defaults")
vim.o.winborder = "single"
-- vim.o.guifont = "JetBrainsMono Nerd Font:h10"

local orgmode_clock = require("plugins.custom.orgmode_clock")
orgmode_clock.start_auto_update()
