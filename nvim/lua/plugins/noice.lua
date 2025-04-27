return {
  {
    lazy = true,
    "folke/noice.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("noice").setup({
        routes = {
          {
            filter = {
              event = "notify",
              find = "No information available",
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "書込み",
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = "msg_show",
              kind = "emsg",
              find = "E382: 'buftype'",
            },
            opts = { skip = true },
          },
        },
      })
    end,
  },
}
