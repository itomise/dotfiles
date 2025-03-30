local function collapse_or_parent()
  local api = require("nvim-tree.api")
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    api.node.navigate.parent_close()
  else
    api.node.navigate.parent()
  end
end

local function edit_or_open()
  local api = require("nvim-tree.api")
  -- expand or collapse folder
  api.node.open.edit()
end

return {
  "nvim-tree/nvim-tree.lua",
  config = true,
  keys = {
    { mode = "n", "<C-n>", "<cmd>NvimTreeToggle<CR>" },
    { mode = "n", "h", collapse_or_parent },
    { mode = "n", "l", edit_or_open },
  },
}
