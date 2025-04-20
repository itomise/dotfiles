local lspconfig = require("lspconfig")

-- 各LSPサーバー共通の設定
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  local buf_set_keymap = vim.api.nvim_buf_set_keymap

  -- keybind
  buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap(bufnr, "n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap(bufnr, "n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap(bufnr, "n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
end

-- mason-lspconfigと連携して設定を適用
require("mason-lspconfig").setup_handlers({
  function(server_name)
    -- fsautocompleteは無効化し、Ionide-vimプラグインを使用
    if server_name ~= "fsautocomplete" then
      lspconfig[server_name].setup({
        on_attach = on_attach,
      })
    end
  end,
})
