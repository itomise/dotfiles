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
      {
        "<leader>ff",
        function()
          local cwd = vim.fn.expand("%:p:h")

          -- git repo かどうか判定
          local is_git_repo = vim.fn.system({ "git", "-C", cwd, "rev-parse", "--is-inside-work-tree" })
          local is_git = vim.v.shell_error == 0 and is_git_repo:match("true") ~= nil

          if is_git then
            require("telescope.builtin").find_files({
              prompt_title = "Git files (from CWD)",
              cwd = cwd,
              find_command = { "git", "-C", cwd, "ls-files" },
            })
          else
            require("telescope.builtin").find_files({
              prompt_title = "All files (no git)",
              cwd = cwd,
              hidden = true,
            })
          end
        end,
        desc = "Find files (Git-aware from current dir)",
      },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
    },
    opts = {
      defaults = {
        -- 検索結果のパス表示設定
        path_display = { "truncate" },
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
