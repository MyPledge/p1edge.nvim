---@type table
return {
  name = "rust",

  -- LSP：使用 rust_analyzer
  -- 简单写法：直接列出 server 名称
  lsp = { "rust_analyzer" },

  -- Treesitter 语法高亮/缩进
  treesitter = {
    "rust",
    "toml",
  },

  -- 格式化工具（配合 conform.nvim）
  -- 需要本机安装 `rustfmt`（通常是 `rustup component add rustfmt`）
  fmt = {
    "rustfmt",
  },
}

