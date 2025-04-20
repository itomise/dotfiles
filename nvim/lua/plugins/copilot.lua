return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- FIXME: node 22 未満で実行すると copilot が対応してないので、絶対パスで指定している状態
        -- 22 未満で実行される状況が修正できたら消す
        copilot_node_command = vim.fn.expand("~/.asdf/installs/nodejs/22.14.0/bin/node"),
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<Tab>",
            accept_word = "<C-g><C-w>",
            accept_line = false,
            next = "<C-g><C-n>",
            prev = "<C-g><C-p>",
            dismiss = "<C-g><BS>",
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          ["."] = false,
        },
      })
    end,
  },
}
