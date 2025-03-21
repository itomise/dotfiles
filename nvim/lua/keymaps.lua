-- jj で Insert mode から Normal mode に戻る
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Exit insert mode with jj' })

-- ノーマルモードで <Esc> を押すと検索のハイライトをクリア
-- 詳細は `:help hlsearch` を参照
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- 診断キーマップ
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
