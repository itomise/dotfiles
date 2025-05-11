return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- ファイル保存直前でロード → 即実行
    opts = {
      format_on_save = false, -- 自動機能は使わず自前で制御
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        terraform = { "terraform_fmt" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          -- 直前の編集と同じ undo ブロックに結合
          pcall(vim.cmd, "silent undojoin")

          -- 同期実行でフォーマット
          require("conform").format({
            bufnr = args.buf,
            lsp_fallback = true, -- LSP が formatter を持つなら利用
            timeout_ms = 1000,
          })
        end,
      })
    end,
  },
}
