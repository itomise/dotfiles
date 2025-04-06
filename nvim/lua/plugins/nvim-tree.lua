return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  config = function()
    require("nvim-tree").setup({
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function collapse_or_parent()
          local node = api.tree.get_node_under_cursor()
          if node.nodes then
            api.node.navigate.parent_close()
          else
            api.node.navigate.parent()
          end
        end

        local function edit_or_open()
          api.node.open.edit()
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "h", collapse_or_parent, opts)
        vim.keymap.set("n", "l", edit_or_open, opts)
      end,
    })
  end,
  keys = {
    { mode = "n", "<C-n>", "<cmd>NvimTreeToggle<CR>" },
  },
}
