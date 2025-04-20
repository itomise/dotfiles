-- options
require("config.options")

-- keymaps
require("keymaps")

if vim.g.vscode then
  -- plugin
  require("config.vscode-lazy")
else
  -- plugin
  require("config.lazy")
  -- lsp setting
  require("lsp")
end

