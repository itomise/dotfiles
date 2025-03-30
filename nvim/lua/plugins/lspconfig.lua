return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "cssls",
          "dockerls",
          "eslint",
          "html",
          "jsonls",
          "kotlin_language_server",
          "lua_ls",
          "pyright",
          "rust_analyzer",
          "sqlls",
          "stylelint_lsp",
          "ts_ls",
        },
        automatic_installation = true,
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "stylua",
        },
        auto_update = true,
        run_on_start = true,
      })
    end,
  },
}
