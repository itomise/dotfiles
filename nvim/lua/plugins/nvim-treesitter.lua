return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = "all",
        auto_install = true,
        ignore_install = {},
        modules = {},
        sync_install = false,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local MAX_FILESIZE = 2 * 1024 * 1024

            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > MAX_FILESIZE then
              return true
            end
          end,
        },
        indent = { enable = true },
      })
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "CursorMoved",
  },
}
