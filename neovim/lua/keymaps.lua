local map = vim.keymap.set

-- set leader key
vim.g.mapleader = " "

-- treat ctrl-j as esc
map({ "i", "v", "c", "n" }, "<C-j>", "<Esc>", { noremap = true })

-- swap ; and :
map({ "n", "v", "o" }, ";", ":", { noremap = true })
map({ "n", "v", "o" }, ":", ";", { noremap = true })

-- turn highlight off with esc twice
map("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true })
map("n", "<C-j><C-j>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true })

-- window keymap
map("n", "<Leader>h", "<C-w>h", { noremap = true })
map("n", "<Leader>j", "<C-w>j", { noremap = true })
map("n", "<Leader>k", "<C-w>k", { noremap = true })
map("n", "<Leader>l", "<C-w>l", { noremap = true })

-- tab keymap
map("n", "<C-n>", "<cmd>tabnext<CR>", { noremap = true, silent = true })
map("n", "<C-p>", "<cmd>tabprevious<CR>", { noremap = true, silent = true })

-- don't move cursor when highlighting word on cursor
local function stay_star(cmd)
  local view = vim.fn.winsaveview()
  vim.cmd("keepj normal! " .. cmd)
  vim.fn.winrestview(view)
end

map("n", "*", function()
  if vim.v.count > 0 then
    -- カウント付きなら通常の * にフォールバック
    return "*"
  end
  stay_star("*")
  return ""
end, { expr = true, silent = true })

map("n", "#", function()
  if vim.v.count > 0 then
    return "#"
  end
  stay_star("#")
  return ""
end, { expr = true, silent = true })

-- reload init.lua
map("n", "<leader>s", function()
  vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
end, { silent = true, noremap = true })
