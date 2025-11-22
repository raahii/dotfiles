local vim = vim
local fn  = vim.fn
local cmd = vim.cmd
local api = vim.api
local map = vim.keymap.set
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug("Shougo/vimproc.vim", { ["do"] = "make" })

-- filer
Plug("vifm/vifm.vim")
Plug("scrooloose/nerdtree")

-- yank
Plug("bfredl/nvim-miniyank")

-- formatting without blocking
Plug("dense-analysis/ale")

-- fuzzy searching
Plug("junegunn/fzf", { ["do"] = fn["fzf#install"] })
Plug("junegunn/fzf.vim")


-- operaion supports
Plug("tpope/vim-surround")
Plug("tomtom/tcomment_vim")
Plug("mattn/emmet-vim")

-- snippets
Plug("SirVer/ultisnips")
Plug("honza/vim-snippets")

-- languages
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("wuelnerdotexe/vim-astro")

-- plantuml
Plug("aklt/plantuml-syntax")
Plug("weirongxu/plantuml-previewer.vim")

-- status line
Plug("vim-airline/vim-airline")
Plug("vim-airline/vim-airline-themes")

-- Github / open-browser
Plug("tyru/open-browser.vim")
Plug("tyru/open-browser-github.vim")

vim.call("plug#end")

-- configs of nerdtree {{{
map({ "n", "v", "o" }, "<C-e>", "<cmd>NERDTreeToggle<CR>", { noremap = true })
map({ "n", "v", "o" }, "<C-t>", "<cmd>NERDTreeFind<CR>",   { noremap = true })
cmd("filetype plugin indent on")
-- }}}

-- configs of nvim-miniyank{{{
map("", "p", "<Plug>(miniyank-autoput)")
map("", "P", "<Plug>(miniyank-autoPut)")
-- }}}

-- configs of ale {{{
vim.g.ale_linters_explicit    = 1
vim.g.ale_lint_on_save        = 0
vim.g.ale_lint_on_enter       = 0
vim.g.ale_lint_on_insert_leave = 0
vim.g.ale_lint_on_text_changed = "never"
vim.g.ale_fix_on_save         = 1
vim.g.ale_completion_enabled  = 0
vim.g.ale_disable_lsp         = 1
vim.g.ale_set_quickfix        = 0
vim.g.ale_set_loclist         = 0

vim.g.ale_fixers = {
  go               = { "gofmt", "goimports" },
  python           = { "black", "isort" },
  sh               = { "shfmt" },
  html             = { "prettier" },
  javascript       = { "prettier" },
  javascriptreact  = { "prettier" },
  typescript       = { "prettier" },
  typescriptreact  = { "prettier" },
  vue              = { "eslint" },
  yaml             = { "prettier" },
}

cmd([[
highlight clear ALEErrorSign
highlight clear ALEWarningSign
]])

vim.g.ale_sign_error   = "⚑"
vim.g.ale_sign_warning = "⚑"
-- }}}

-- configs of fzf.vim {{{
map("n", "<Leader>gf", "<cmd>GFiles<CR>", { noremap = true })
map("n", "<Leader>f",  "<cmd>Files<CR>",  { noremap = true })
map("n", "<Leader>r",  "<cmd>Rg<CR>",     { noremap = true })
-- }}}

-- configs of snippet {{{
vim.g.UltiSnipsExpandTrigger = "<c-k>"
-- }}}

-- configs of nvim-treesitter {{{
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "go",
    "python",
    "java",
    "kotlin",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "vue",
    "sql",
    "yaml",
    "toml",
    "json",
    "dockerfile",
    "markdown",
    "fish",
  },
  sync_install = false,
  auto_install = true,
})
-- }}}

-- configs of astro {{{
vim.g.astro_typescript = "enable"
-- }}}

-- configs of vim-airline {{{
vim.opt.showmode   = false
vim.opt.cmdheight  = 1
vim.opt.laststatus = 2
vim.g.airline_theme = "angr"
-- }}}

-- configs of Github {{{
map("n", "<leader>o", ":'<,'>OpenGithubFile<CR>", {
  silent = true,
  noremap = true,
})
-- }}}
