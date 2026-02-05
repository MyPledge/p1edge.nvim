---@type table
return {
  name = "lua",

  -- LSP 配置（两种写法选一）：
  -- 1. 简单写法：lsp = { "lua_ls" }
  -- 2. 详细写法：lsp.servers = { lua_ls = { ...opts } }
  lsp = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
    },
  },

  -- treesitter 语法高亮解析器
  treesitter = {
    "lua",
    "luadoc",
    "printf",
    "vim",
    "vimdoc",
  },

  -- 格式化工具（用于 conform.nvim）
  -- 简单写法：当前语言 filetype = "lua"
  -- 会生成：formatters_by_ft = { lua = { "stylua" } }
  fmt = {
    "stylua",
  },
}

