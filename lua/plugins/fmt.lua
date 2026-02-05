return {
  "stevearc/conform.nvim",

  -- 保存前自动格式化
  event = { "BufWritePre" },

  opts = function()
    local formatters_by_ft = {}

    local ok, lang = pcall(require, "lang")
    if ok then
      local specs = lang.get_specs()
      if specs and specs.formatters_by_ft then
        formatters_by_ft = specs.formatters_by_ft
      end
    end

    return {
      formatters_by_ft = formatters_by_ft,

      -- 保存自动格式化：可通过变量关闭
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 3000,
          lsp_fallback = true,
        }
      end,
    }
  end,

  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format buffer",
    },
  },
}

