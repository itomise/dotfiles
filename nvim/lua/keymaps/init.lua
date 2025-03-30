-- jj で Insert mode から Normal mode に戻る
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- ノーマルモードで <Esc> を押すと検索のハイライトをクリア
-- 詳細は `:help hlsearch` を参照
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 診断キーマップ
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

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
