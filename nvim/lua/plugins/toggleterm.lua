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

local function config()
  require("toggleterm").setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return 50
        -- return vim.o.columns * 0.4
      end
    end,
    direction = "float",
    float_opts = {
      border = "curved",
    },
  })
end

return {
  "akinsho/toggleterm.nvim",

  module = { "toggleterm" },
  keys = {
    { [[<C-w>f]], toggle_term, mode = "n" },
    { [[<C-w>t]], toggle_tig, mode = "n" },
    { [[<C-w>h]], vertical_term, mode = "n" },
  },
  config = config,
}
