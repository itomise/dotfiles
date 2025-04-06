return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",            desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",             desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",               desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",             desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",              desc = "Recent files" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",  desc = "Document symbols" },
      { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>",           desc = "Diagnostics" },
      { "<leader>fr", "<cmd>Telescope lsp_references<cr>",        desc = "References" },
      { "<leader>fi", "<cmd>Telescope lsp_implementations<cr>",   desc = "Implementations" },
    },
    opts = {
      defaults = {
        -- 検索結果のパス表示設定
        path_display = { "truncate" },
        -- 特定のディレクトリやファイルを検索対象から除外
        file_ignore_patterns = {
          ".DS_Store",
          ".git/",
          "node_modules/",
          "storybook%-static/",
          "build/",
        },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
