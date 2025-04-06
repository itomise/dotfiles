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
    lspconfig[server_name].setup({
      on_attach = on_attach,
    })
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
  end,

  -- TypeScriptの設定
  ["ts_ls"] = function()
    require("lspconfig").ts_ls.setup({
      on_attach = on_attach,
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    })
  end,

  ["eslint"] = function()
    require("lspconfig").eslint.setup({
      on_attach = on_attach,
      cmd = { "vscode-eslint-language-server", "--stdio" },
      settings = {
        format = { enable = true },
      },
    })
  end,

  -- Haskellの設定
  ["hls"] = function()
    require("lspconfig").hls.setup({
      on_attach = on_attach,
      settings = {
        haskell = {
          formattingProvider = "ormolu", -- ormoluフォーマッター使用
        },
      },
    })
  end,
  
  -- F#の設定
  ["fsautocomplete"] = function()
    require("lspconfig").fsautocomplete.setup({
      on_attach = on_attach,
    })
  end,
})
