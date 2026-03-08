return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ts_ls",
        "denols",
        "eslint",
        "hls",
        "fsautocomplete",
        "terraformls",
        "gopls",
      },
      automatic_installation = true,
      automatic_enable = false, -- 個別設定するので自動で有効化しない
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })

      vim.lsp.config("denols", {
        root_markers = { "deno.json", "deno.jsonc" },
        workspace_required = true,
        init_options = {
          lint = true,
          unstable = true,
        },
      })

      vim.lsp.config("ts_ls", {
        workspace_required = true,
        root_dir = function(bufnr, on_dir)
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if bufname == "" then
            return
          end
          local fname = vim.fs.dirname(bufname)
          -- まず TypeScript プロジェクトの root を見つける
          local ts_markers = vim.fs.find({ "package.json", "tsconfig.json", "jsconfig.json" },
            { path = fname, upward = true })
          if #ts_markers == 0 then
            return
          end
          local ts_root = vim.fs.dirname(ts_markers[1])
          -- deno.json が ts_root と同じかその中にある場合のみ Deno プロジェクトとみなす
          -- (ホームディレクトリなど親にある deno.json は無視)
          local deno_markers = vim.fs.find({ "deno.json", "deno.jsonc" }, { path = fname, upward = true })
          if #deno_markers > 0 then
            local deno_root = vim.fs.dirname(deno_markers[1])
            -- deno_root が ts_root で始まる場合のみブロック (deno.json が ts プロジェクト内にある)
            if deno_root:find(ts_root, 1, true) == 1 then
              return
            end
          end
          on_dir(ts_root)
        end,
      })

      vim.lsp.config("eslint", {
        root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json", "eslint.config.js", "eslint.config.mjs", "package.json" },
      })

      vim.lsp.config("pyright", {})

      vim.lsp.config("hls", {})

      vim.lsp.config("fsautocomplete", {})

      vim.lsp.config("terraformls", {})

      vim.lsp.config("gopls", {
        root_markers = { "go.mod", "go.work", ".git" },
        settings = {
          gopls = {
            gofumpt = true,
            analyses = {
              unusedparams = true,
              unusedvariable = true,
            },
            staticcheck = true,
          },
        },
      })

      vim.lsp.config("kotlin_lsp", {
        cmd = { "kotlin-lsp", "--stdio" },
        filetypes = { "kotlin" },
        root_markers = { "settings.gradle", "settings.gradle.kts", "build.gradle", "build.gradle.kts", "pom.xml", ".git" },
      })

      vim.lsp.enable({
        "lua_ls",
        "denols",
        "ts_ls",
        "eslint",
        "pyright",
        "hls",
        "fsautocomplete",
        "terraformls",
        "kotlin_lsp",
        "gopls",
      })
    end,
  },
}
