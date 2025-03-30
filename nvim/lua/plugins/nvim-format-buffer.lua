return {
  {
    "acro5piano/nvim-format-buffer",
    config = function()
      require("nvim-format-buffer").setup({
        -- verbose = false, -- デフォルト値
        format_rules = {
          { pattern = { "*.lua" }, command = "stylua -" },
          {
            pattern = { "*.ts", "*.tsx", "*.css", "*.md" },
            command = function()
              return "prettier --stdin-filepath '" .. vim.api.nvim_buf_get_name(0) .. "'"
            end,
          },
        },
      })
    end,
  },
}
