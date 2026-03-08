return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle blame" })
          map("n", "<leader>gB", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame line" })
          map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
          map("n", "<leader>gd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>gD", function()
            gs.diffthis("~")
          end, { desc = "Diff this ~" })
          map("n", "<leader>gP", function()
            local line = vim.fn.line(".")
            local file = vim.fn.expand("%:p")
            local result = vim.fn.system(
              "git blame -l -L " .. line .. "," .. line .. " -- " .. vim.fn.shellescape(file)
            )
            local hash = result:match("^%^?(%x+)")
            if not hash or hash:match("^0+$") then
              vim.notify("Not committed yet", vim.log.levels.WARN)
              return
            end
            vim.fn.jobstart(
              { "gh", "api", "repos/{owner}/{repo}/commits/" .. hash .. "/pulls", "--jq", ".[0].html_url" },
              {
                stdout_buffered = true,
                on_stdout = function(_, data)
                  local url = vim.trim(table.concat(data, ""))
                  if url == "" or url == "null" then
                    vim.notify("No PR found for " .. hash:sub(1, 8), vim.log.levels.WARN)
                    return
                  end
                  vim.ui.open(url)
                end,
              }
            )
          end, { desc = "Open PR for blame" })
        end,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 100,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      })
    end,
  },
}
