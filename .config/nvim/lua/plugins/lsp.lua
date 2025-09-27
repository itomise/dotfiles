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
      local util = require("lspconfig.util")

      vim.lsp.config.lua_ls = {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      }

      vim.lsp.config.denols = {
        root_dir = util.root_pattern("deno.json", "deno.jsonc"),
        root_markers = { "deno.json", "deno.jsonc", "deps.ts" },
        workspace_required = true,
        init_options = {
          lint = true,
          unstable = true,
        },
      }

      vim.lsp.config.ts_ls = {
        root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
        workspace_required = true,
      }

      vim.lsp.config.eslint = {}
      vim.lsp.config.pyright = {}
      vim.lsp.config.hls = {}
      vim.lsp.config.fsautocomplete = {}
      vim.lsp.config.terraformls = {}

      vim.lsp.config.kotlin_language_server = {
        cmd = { "kotlin-lsp", "--stdio" },
        root_dir = util.root_pattern("build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts"),
        filetypes = { "kotlin" },
        settings = {}
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
