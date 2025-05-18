return {
  "haya14busa/vim-asterisk",
  config = function()
    vim.g["asterisk#keeppos"] = 1
    vim.api.nvim_set_keymap("", "*", "<Plug>(asterisk-z*)", {})
    vim.api.nvim_set_keymap("", "#", "<Plug>(asterisk-z#)", {})
    vim.api.nvim_set_keymap("", "g*", "<Plug>(asterisk-gz*)", {})
    vim.api.nvim_set_keymap("", "g#", "<Plug>(asterisk-gz#)", {})
  end,
}
