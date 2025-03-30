-- インデント設定
vim.opt.expandtab = true -- タブをスペースに変換
vim.opt.shiftwidth = 2 -- インデント幅を2に設定
vim.opt.tabstop = 2 -- タブ文字の表示幅を2に設定
vim.opt.softtabstop = 2 -- タブキーを押したときのスペースの数を2に設定

-- シンタックスを有効化
vim.cmd("syntax enable")

-- カラースキームを設定
-- vim.cmd('colorscheme tokyonight')  -- または他のカラースキーム

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 行番号を表示
vim.opt.number = true

-- クリップボードを有効化 (schedule で遅延実行)
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

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

if not vim.g.vscode then
	-- マウス有効化
	vim.opt.mouse = "a"

	-- キーマップ設定を読み込む
	require("keymaps")

	-- plugin
	require("config.lazy")
end
