return {
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { desc = "Delete buffer", silent = true })
    vim.keymap.set('n', '<leader>bw', ':Bwipeout<CR>', { desc = "Wipeout buffer", silent = true })
  end
}
