local function toggle_term()
  local term = require("toggleterm.terminal").Terminal:new({})
  term:toggle()
end

local function toggle_tig()
  local tig = require("toggleterm.terminal").Terminal:new({ cmd = "tig" })
  tig:toggle()
end

local function vertical_term()
  local term = require("toggleterm.terminal").Terminal:new({
    direction = "vertical",
  })
  term:toggle()
end

local function horizontal_term()
  local term = require("toggleterm.terminal").Terminal:new({
    direction = "horizontal",
  })
  term:toggle()
end

local function config()
  require("toggleterm").setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return 80
      end
    end,
    direction = "float",
    float_opts = {
      border = "curved",
    },
    persist_size = true,
    persist_mode = true,
    auto_scroll = true,
  })
end

return {
  "akinsho/toggleterm.nvim",

  module = { "toggleterm" },
  keys = {
    { [[<leader>tf]], toggle_term,     mode = "n", desc = "Toggle terminal" },
    { [[<leader>tt]], toggle_tig,      mode = "n", desc = "Toggle tig" },
    { [[<leader>tv]], vertical_term,   mode = "n", desc = "Toggle vertical terminal" },
    { [[<leader>th]], horizontal_term, mode = "n", desc = "Toggle horizontal terminal" },
  },
  config = config,
}
