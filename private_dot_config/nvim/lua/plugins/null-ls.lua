return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",       -- none-ls の依存関係
    "williamboman/mason.nvim",     -- Mason と統合するために必要
    "jayp0521/mason-null-ls.nvim", -- Mason と none-ls の統合
  },
  config = function()
    local null_ls = require("null-ls")
    require("mason-null-ls").setup({
      ensure_installed = { "prettier", "stylua", "stylelint-lsp", "denols" },
      automatic_installation = true,
    })

    local function is_deno_project()
      local deno_files = { "deno.json", "deno.jsonc", "deno.lock" }
      for _, file in ipairs(deno_files) do
        if vim.fn.filereadable(file) == 1 then
          return true
        end
      end
      return false
    end

    -- null-ls のソース設定
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier.with({
          condition = function()
            return not is_deno_project()
          end,
          filetypes = { "typescriptreact", "typescript", "json" },
          prefer_local = "node_modules/.bin",
          cwd = function(params)
            return vim.fn.expand("%:p:h")
          end,
        }),
        null_ls.builtins.formatting.stylelint.with({
          filetypes = { "typescriptreact" },
        }),
      },
    })

    -- Go: 保存時に import を自動整理
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function(args)
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 3000)
        for _, res in pairs(result or {}) do
          for _, action in pairs(res.result or {}) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
            end
          end
        end
      end,
    })

    -- 保存時に自動フォーマット（フォーマッターがある場合のみ）
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf })
        local has_formatter = false
        for _, client in ipairs(clients) do
          if client.supports_method("textDocument/formatting") then
            has_formatter = true
            break
          end
        end
        if not has_formatter then
          return
        end

        pcall(vim.cmd, "silent undojoin")

        vim.lsp.buf.format({
          bufnr = args.buf,
          timeout_ms = 5000,
          async = false,
        })
      end,
    })
  end,
}
