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
      },
      automatic_installation = true,
      automatic_enable = false, -- 個別設定するので自動で有効化しない
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      }

      vim.lsp.config.denols = {
        cmd = { "deno", "lsp" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        root_markers = { "deno.json", "deno.jsonc" },
        workspace_required = true,
        init_options = {
          lint = true,
          unstable = true,
        },
      }

      vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        workspace_required = true,
        root_dir = function(fname)
          local util = vim.lsp.util
          -- deno プロジェクト（deno.json/deno.jsonc が存在）では ts_ls を起動しない
          local deno_root = util.root_pattern("deno.json", "deno.jsonc")(fname)
          if deno_root then
            return nil
          end
          -- deno プロジェクトでない場合は通常の root_dir 検出
          return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
        end,
      }

      vim.lsp.config.eslint = {
        cmd = { "vscode-eslint-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
        root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json", "package.json" },
      }

      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
      }

      vim.lsp.config.hls = {
        cmd = { "haskell-language-server-wrapper", "--lsp" },
        filetypes = { "haskell", "lhaskell" },
        root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml" },
      }

      vim.lsp.config.fsautocomplete = {
        cmd = { "fsautocomplete", "--background-service-enabled" },
        filetypes = { "fsharp" },
        root_markers = { "*.sln", "*.fsproj", ".git" },
      }

      vim.lsp.config.terraformls = {
        cmd = { "terraform-ls", "serve" },
        filetypes = { "terraform", "terraform-vars" },
        root_markers = { ".terraform", ".git" },
      }

      vim.lsp.config.kotlin_language_server = {
        cmd = { "kotlin-lsp", "--stdio" },
        filetypes = { "kotlin" },
        root_markers = { "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts" },
      }

      vim.lsp.enable({
        'lua_ls',
        'denols',
        'ts_ls',
        'eslint',
        'pyright',
        'hls',
        'fsautocomplete',
        'terraformls',
        'kotlin_language_server',
      })
    end,
  },
}
