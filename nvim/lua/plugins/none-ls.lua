-- formatting and linting
return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspNullFormatting", {})

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.biome.with({
          only_local = "node_modules/.bin",
          condition = function(utils)
            return utils.root_has_file({ "biome.json" })
          end,
        }),
        null_ls.builtins.formatting.prettierd.with({
          prefer_local = "node_modules/.bin",
          extra_filetypes = { "svelte" },
          disabled_filetypes = { "markdown" },
          condition = function(utils)
            return not utils.root_has_file({ "biome.json", "deno.json", "deno.jsonc" })
          end,
        }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylelint.with({
          extra_filetypes = { "css", "scss", "less", "tsx", "typescriptreact" },
        }),
      },
      timeout_ms = 5000,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                async = false,
                filter = function(c)
                  return c.name == "null-ls"
                end,
              })
            end,
          })
        end
      end,
    })
  end,
}
