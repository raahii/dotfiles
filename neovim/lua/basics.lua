
-- appearance
vim.cmd.syntax("on")
vim.opt.background = "dark"
vim.cmd('silent! colorscheme gruvbox')

vim.api.nvim_set_hl(0, "Folded", { ctermbg = "Green", ctermfg = "Black" })

-- basics
local opt = vim.opt
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.ttyfast = true
opt.lazyredraw = true
opt.encoding = "utf-8"
opt.modifiable = true
opt.write = true
opt.fileencoding = "utf-8"
opt.fileencodings = { "utf-8", "iso-2022-jp", "euc-jp", "sjis" }
opt.fenc = "utf-8"
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.expandtab = true
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undofiles")
opt.swapfile = false
opt.scrolloff = 5
opt.writebackup = false
opt.backup = false
opt.backspace = { "indent", "eol", "start" }
opt.visualbell = false
opt.incsearch = true
opt.hlsearch = true
opt.mouse = "a"
opt.history = 1000
opt.list = true
opt.listchars = {
  tab = ">-",
  trail = "-",
  extends = ">",
  precedes = "<",
  nbsp = "%"
}
opt.hidden = true
opt.ambiwidth = "single"
opt.splitright = true
opt.foldmethod = "marker"
opt.showmatch = true
opt.wildmenu = true
opt.tags = ".tags"

-- clipboard
if vim.fn.has("mac") == 1 then
  opt.clipboard = "unnamed"
else
  opt.clipboard = "unnamedplus"
end

