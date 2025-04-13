-- jj で Insert mode から Normal mode に戻る
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("i", "っj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("i", "っっj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("i", "っっっj", "<ESC>", { desc = "Exit insert mode with jj" })

-- ノーマルモードで <Esc> を押すと検索のハイライトをクリア
-- 詳細は `:help hlsearch` を参照
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 別ウィンドウで編集された内容を自動で反映する
vim.opt.autoread = true

-- ファイル変更を自動検出して更新を反映するための設定
-- 定期的にバッファの変更を確認して更新
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- タイマーイベントを設定して定期的に checktime を実行
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.timer_start(1000, function()
      vim.cmd("checktime")
      return 1000             -- 1秒ごとに実行を継続
    end, { ["repeat"] = -1 }) -- 無限に繰り返す
  end,
})

-- 診断キーマップ
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NvimTree focus on current file
vim.keymap.set("n", "<C-g>", function()
  local api = require("nvim-tree.api")
  api.tree.find_file({ open = true, focus = true })
end, { desc = "Focus current file in nvim-tree" })

vim.keymap.set("n", "q", "<Nop>", { desc = "Disable q key in normal mode" })

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit Vim" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- window (vertical)
vim.keymap.set("n", "=", function()
  vim.cmd("vertical resize -5")
end, { desc = "resize vertical -5" })
vim.keymap.set("n", "-", function()
  vim.cmd("vertical resize +5")
end, { desc = "resize vertical +5" })

-- window (horizontal)
vim.keymap.set("n", "+", function()
  vim.cmd("resize -5")
end, { desc = "resize horizontal -5" })
vim.keymap.set("n", "_", function()
  vim.cmd("resize +5")
end, { desc = "resize horizontal +5" })

vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode with Escape" })
