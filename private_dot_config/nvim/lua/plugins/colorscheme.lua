-- tried: tokyonight-night (folke/tokyonight.nvim), dracula (Mofiqul/dracula.nvim), ayu-dark (Shatur/neovim-ayu)
return {
  "RRethy/base16-nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("base16-circus")
  end,
}
