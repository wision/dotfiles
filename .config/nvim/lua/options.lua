vim.opt.listchars = "tab:▸—,eol:.,nbsp:␣,trail:·,extends:›,precedes:‹"
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.colorcolumn = "101"
vim.opt.cursorline = true
vim.opt.backupcopy = "yes"
-- vim.opt.clipboard = "unnamedplus" -- using global clipboard breaks neoclip yank history plugin
vim.opt.ttyfast = true

-- smart case search.. one uppercase letter makes it case sensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- enable mousemoveevent
vim.o.mousemoveevent = true

--vim.g.loaded_netrw = 1
vim.g.loaded_matchparen = 1

-- Set the sign column to 3 characters wide
vim.opt.signcolumn = "yes:3"


--vim.g.mapleader = " "
--vim.g.autoformat = false
--
--vim.scriptencoding = "utf-8"
--vim.opt.colorcolumn = "101"
--vim.opt.encoding = "utf-8"
--vim.opt.fileencoding = "utf-8"
--
--vim.opt.number = true
--
--vim.opt.title = true
--vim.opt.autoindent = true
--vim.opt.smartindent = true
--vim.opt.hlsearch = true
--vim.opt.backup = false
--vim.opt.showcmd = true
--vim.opt.cmdheight = 1
--vim.opt.laststatus = 2
--vim.opt.expandtab = false
--vim.opt.scrolloff = 999
--vim.opt.shell = "alacritty"
--vim.opt.backupskip = { "/tmp/*" }
--vim.opt.inccommand = "split"
--vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
--vim.opt.smarttab = false
--vim.opt.breakindent = true
--vim.opt.shiftwidth = 4
--vim.opt.tabstop = 4
--vim.opt.wrap = true -- No Wrap lines
--vim.opt.backspace = { "start", "eol", "indent" }
--vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
--vim.opt.wildignore:append({ "*/node_modules/*" })
--vim.opt.splitbelow = true -- Put new windows below current
--vim.opt.splitright = true -- Put new windows right of current
--vim.opt.splitkeep = "cursor"
--vim.opt.mouse = "a"
--
--vim.opt.showtabline = 2 -- Always show tabs
--
--vim.o.mousemoveevent = true
--
---- Undercurl
--vim.cmd([[let &t_Cs = "\e[4:3m"]])
--vim.cmd([[let &t_Ce = "\e[4:0m"]])
--
---- Add asterisks in block comments
--vim.opt.formatoptions:append({ "r" })
--
--if vim.fn.has("nvim-0.8") == 1 then
--	vim.opt.cmdheight = 0
--end
