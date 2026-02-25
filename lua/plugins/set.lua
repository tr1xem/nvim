vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true

vim.g.maplocalleader = "," -- local leader
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.diagnostic.config({
	virtual_text = true,
})

-- Code fold

function _G.custom_foldtext()
	local startLine = vim.fn.getline(vim.v.foldstart)
	local lineCount = vim.v.foldend - vim.v.foldstart + 1

	-- remove leading whitespace
	startLine = startLine:gsub("^%s*", "")

	return ("%s  󰁂 %d lines "):format(startLine, lineCount)
end

vim.opt.foldtext = "v:lua.custom_foldtext()"
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldnestmax = 5
vim.o.foldminlines = 1
vim.o.foldlevelstart = 99
vim.o.foldlevel = 99
vim.o.foldcolumn = "1"
vim.o.foldenable = true
vim.opt.fillchars = {
	eob = " ",
	fold = " ",
	foldopen = "",
	foldsep = " ",
	foldclose = "",
}
