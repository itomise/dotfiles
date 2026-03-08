return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = "all",
      auto_install = true,
      ignore_install = {},
      highlight = {
        enable = true,
        disable = function(lang, buf)
          if lang == "markdown" then
            return true
          end
          local MAX_FILESIZE = 2 * 1024 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > MAX_FILESIZE then
            return true
          end
        end,
      },
      indent = { enable = true },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "CursorMoved",
  },
}
