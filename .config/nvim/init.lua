vim.loader.enable()
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{
			import = "plugins",
		},
	},
	defaults = {
		lazy = false,
	},
	checker = {
		enabled = false, -- disable plugin update check
	},
	performance = {
		cache = {
			enabled = true,
			-- disable_events = {},
		},
	},
})

require("options")
require("keymaps")
require("telescope-config")
