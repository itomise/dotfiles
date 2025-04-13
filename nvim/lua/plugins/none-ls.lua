-- formatting and linting
return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.completion.spell,
        require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylelint.with({
          extra_filetypes = { "css", "scss", "less", "typescriptreact" },
        }),
      },
    })
  end,
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
}
