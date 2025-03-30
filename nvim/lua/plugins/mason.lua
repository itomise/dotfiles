-- Mason.nvim の設定
-- パッケージマネージャーとして機能し、LSP、リンター、フォーマッターなどのツールを管理
return {
  {
    -- メインのMasonプラグイン
    -- UI操作やパッケージのインストール管理を担当
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    -- Mason と LSP の橋渡しを行うプラグイン
    -- Mason でインストールしたLSPをnvim-lspconfigで簡単に設定できるようにする
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    -- Mason用の自動インストーラープラグイン
    -- 必要なツールを自動的にインストールしてくれる
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
