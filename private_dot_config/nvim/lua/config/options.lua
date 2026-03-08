-- インデント設定
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.cmd("syntax enable")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- display row number
vim.opt.number = true

vim.opt.clipboard = "unnamed,unnamedplus"

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.swapfile = false

-- コメント自動挿入を無効化
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- highlight
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#553311" })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200 })
  end,
})

if not vim.g.vscode then
  vim.opt.mouse = "a"
end
