return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- none-ls の依存関係
    "williamboman/mason.nvim", -- Mason と統合するために必要
    "jayp0521/mason-null-ls.nvim", -- Mason と none-ls の統合
  },
  config = function()
    local null_ls = require("null-ls")
    require("mason-null-ls").setup({
      ensure_installed = { "prettier", "stylua", "stylelint-lsp", "denols" },
      automatic_installation = true,
    })

    -- null-ls のソース設定
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "typescriptreact", "typescript", "json" },
          prefer_local = "node_modules/.bin",
          cwd = function(params)
            return vim.fn.expand("%:p:h")
          end,
        }),
        null_ls.builtins.formatting.stylelint.with({
          filetypes = { "typescriptreact" },
        }),
        null_ls.builtins.formatting.stylua.with({
          filetypes = { "lua" },
        }),
      },
    })

    -- 保存時に自動フォーマット
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        pcall(vim.cmd, "silent undojoin")

        vim.lsp.buf.format({
          bufnr = args.buf,
          timeout_ms = 1000,
          async = false,
        })
      end,
    })
  end,
}
