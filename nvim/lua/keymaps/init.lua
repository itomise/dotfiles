-- jj で Insert mode から Normal mode に戻る
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("i", "っj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("i", "っっj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("i", "っっっj", "<ESC>", { desc = "Exit insert mode with jj" })

vim.keymap.set("n", "q", "<Nop>", { desc = "Disable q key in normal mode" })
vim.keymap.set("n", "Q", "q")

vim.keymap.set("x", "<leader>rr", 'y:%s/<C-r><C-r>"//g<Left><Left>', { desc = "Replace buffer word" })
vim.keymap.set("n", "<leader>rr", 'yiw:%s/<C-r><C-r>"//g<Left><Left>', { desc = "Replace buffer word" })

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- vim.keymap.set("v", "p", '"0p', { silent = true })
-- vim.keymap.set("s", "p", '"0p', { silent = true })
--
vim.keymap.set("n", "<leader>*", "cgn")

vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>")

-- window (vertical)
vim.keymap.set("n", "=", function()
  vim.cmd("vertical resize -5")
end, { desc = "resize vertical -5" })
vim.keymap.set("n", "-", function()
  vim.cmd("vertical resize +5")
end, { desc = "resize vertical +5" })

-- window (horizontal)
vim.keymap.set("n", "+", function()
  vim.cmd("resize -5")
end, { desc = "resize horizontal -5" })
vim.keymap.set("n", "_", function()
  vim.cmd("resize +5")
end, { desc = "resize horizontal +5" })

if not vim.g.vscode then
  vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit Vim" })
  -- window move
  vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
  vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
  vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
  vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

  vim.keymap.set("t", "<ESC><ESC>", [[<C-\><C-n>]], { desc = "Exit terminal mode with Escape" })

  vim.diagnostic.config({
    virtual_text = {
      prefix = "●", -- ● <message>
      spacing = 2,
      source = false, -- ソース名は不要
      format = function(diag)
        return diag.message -- 本文だけを表示
      end,
    },
    signs = true,             -- signcolumn にアイコン
    underline = true,
    update_in_insert = false, -- 挿入モードでは更新しない
    severity_sort = true,     -- 深刻度で並べ替え
    float = {
      border = "rounded",
      source = "always", -- 常に LSP 名を表示
      header = "Diagnostics",
      prefix = "",
    },
  })

  ---------------------------------------------------------------------
  -- 自動フロートポップアップ（カーソル停止時）------------------------
  ---------------------------------------------------------------------
  vim.o.updatetime = 500 -- CursorHold を 250ms で発火
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      -- diagnostic があればフロートを表示、なければ無視
      if not vim.b.disable_diag_hover then
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
      end
    end,
  })

  local opts = { noremap = true, silent = true }
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  vim.keymap.set("n", "gq", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Populate quickfix" }))

  ---------------------------------------------------------------------
  -- LSP Attach 時のバッファローカルキーマップ ------------------------
  ---------------------------------------------------------------------
  local lsp_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
      local bufnr    = args.buf
      local lsp_opts = { noremap = true, silent = true, buffer = bufnr }
      local set      = vim.keymap.set

      set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", lsp_opts, { desc = "Goto definition" }))
      set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", lsp_opts, { desc = "Goto implementation" }))
      set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", lsp_opts, { desc = "Goto references" }))
      set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", lsp_opts, { desc = "Hover" }))
      set("n", "gn", vim.lsp.buf.rename, vim.tbl_extend("force", lsp_opts, { desc = "Rename symbol" }))
      set("n", "ga", vim.lsp.buf.code_action, vim.tbl_extend("force", lsp_opts, { desc = "Code action" }))
    end,
  })

  -- 別ウィンドウで編集された内容を自動で反映する
  vim.opt.autoread = true

  -- ファイル変更を自動検出して更新を反映するための設定
  -- 定期的にバッファの変更を確認して更新
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    callback = function()
      if vim.fn.mode() ~= "c" then
        vim.cmd("checktime")
      end
    end,
  })

  -- タイマーイベントを設定して定期的に checktime を実行
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.fn.timer_start(1000, function()
        vim.cmd("checktime")
        return 1000             -- 1秒ごとに実行を継続
      end, { ["repeat"] = -1 }) -- 無限に繰り返す
    end,
  })

  -- NvimTree focus on current file
  vim.keymap.set("n", "<C-g>", function()
    local api = require("nvim-tree.api")
    api.tree.find_file({ open = true, focus = true })
  end, { desc = "Focus current file in nvim-tree" })
else
  -- tab move
  vim.keymap.set("n", "<C-h>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
  vim.keymap.set("n", "<C-l>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")

  -- comment out
  vim.keymap.set("n", "gc", "<cmd>call VSCodeNotify('editor.action.commentLine')<CR>")
  vim.keymap.set("v", "gc", "<cmd>call VSCodeNotify('editor.action.commentLine')<CR>")

  vim.keymap.set("n", "<leader>q", "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>")
  -- copilot
  vim.keymap.set("i", "<C-l>", "<cmd>call VSCodeNotify('github.copilot.acceptCursorPanelSolution')<CR>")
end
