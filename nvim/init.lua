-- インデント設定
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- シンタックスを有効化
vim.cmd("syntax enable")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 行番号を表示
vim.opt.number = true

vim.opt.clipboard = "unnamedplus"

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
vim.opt.confirm = true
vim.opt.swapfile = false

vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#553311" })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200 })
  end,
})

-- keymaps
require("keymaps")

if vim.g.vscode then
  -- plugin
  require("config.vscode-lazy")
else
  vim.opt.mouse = "a"

  -- plugin
  require("config.lazy")
  -- LSP設定
  require("lsp")
end
