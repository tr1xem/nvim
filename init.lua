vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
require("plugins")
require("plugins.custom.linkhelper")
require("chadrc")
dofile(vim.g.base46_cache .. "defaults")
-- vim.o.guifont = "JetBrainsMono Nerd Font:h10"
