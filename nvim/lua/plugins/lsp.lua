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
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      lspconfig.lua_ls.setup({
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })

      lspconfig.denols.setup({
        root_dir = util.root_pattern("deno.json", "deno.jsonc"),
        root_markers = { "deno.json", "deno.jsonc", "deps.ts" },
        workspace_required = true,
        init_options = {
          lint = true,
          unstable = true,
        },
      })

      lspconfig.ts_ls.setup({
        root_dir = util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
        workspace_required = true,
      })

      lspconfig.eslint.setup({})
      lspconfig.pyright.setup({})
      lspconfig.hls.setup({})
      lspconfig.fsautocomplete.setup({})
      lspconfig.terraformls.setup({})
    end,
  },
}
