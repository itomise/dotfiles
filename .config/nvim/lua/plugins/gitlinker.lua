return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  config = function()
    require('gitlinker').setup({
      router = {
        browse = {
          -- GitHub Enterprise
          ["^github%.%w+%.com"] = require('gitlinker.routers').github_browse,
        },
        blame = {
          ["^github%.%w+%.com"] = require('gitlinker.routers').github_blame,
        },
      }
    })
  end,
  keys = {
    { "gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
  },
}
