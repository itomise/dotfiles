-- F# plugin
return {
  "ionide/Ionide-vim",
  lazy = true,
  ft = { "fs", "fsi", "fsx" },
  dependencies = {
    "neovim/nvim-lspconfig",
  },
}
