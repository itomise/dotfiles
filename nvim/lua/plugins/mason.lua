return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" }, -- 利用するLSPサーバーを指定（例としてlua, python）
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
}
