local M = {}

-- 收集 lang/*.lua 导出的配置
local function load_lang_configs()
  local configs = {}

  local ok_glob, files = pcall(
    vim.fn.glob,
    vim.fn.stdpath("config") .. "/lua/lang/*.lua",
    true,
    true
  )
  if not ok_glob or type(files) ~= "table" then
    return configs
  end

  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if name ~= "init" then
      local ok, cfg = pcall(require, "lang." .. name)
      if ok and type(cfg) == "table" then
        table.insert(configs, cfg)
      else
        vim.notify(
          "lang: failed to load config for " .. name,
          vim.log.levels.WARN
        )
      end
    end
  end

  return configs
end

local function dedup_list(list)
  local seen, out = {}, {}
  for _, v in ipairs(list) do
    if v and not seen[v] then
      table.insert(out, v)
      seen[v] = true
    end
  end
  return out
end

--- 聚合所有语言配置，生成给插件使用的规格
---@return { lsp_servers: string[], lsp_settings: table<string, table>, treesitter: string[], formatters_by_ft: table<string, string[]> }
function M.get_specs()
  local configs = load_lang_configs()

  local lsp_servers = {}
  local lsp_settings = {}
  local ts_langs = {}
  local formatters_by_ft = {}

  local function add_formatters(ft, tools)
    if type(ft) ~= "string" or ft == "" then
      return
    end
    if type(tools) ~= "table" or vim.tbl_isempty(tools) then
      return
    end
    formatters_by_ft[ft] = formatters_by_ft[ft] or {}
    local existing = formatters_by_ft[ft]
    for _, t in ipairs(tools) do
      if t and not vim.tbl_contains(existing, t) then
        table.insert(existing, t)
      end
    end
  end

  for _, cfg in ipairs(configs) do
    -- LSP servers
    if type(cfg.lsp) == "table" then
      -- 形式一：lsp.servers = { lua_ls = { ... }, pyright = { ... } }
      if type(cfg.lsp.servers) == "table" then
        for server, opts in pairs(cfg.lsp.servers) do
          table.insert(lsp_servers, server)
          if type(opts) == "table" and next(opts) ~= nil then
            lsp_settings[server] = opts
          end
        end
      -- 形式二：lsp = { "lua_ls", "pyright" }
      else
        for _, server in ipairs(cfg.lsp) do
          table.insert(lsp_servers, server)
        end
      end
    end

    -- treesitter
    if type(cfg.treesitter) == "table" then
      for _, lang in ipairs(cfg.treesitter) do
        table.insert(ts_langs, lang)
      end
    end

    -- formatters（用于 conform.nvim）
    -- 支持两种写法：
    -- 1) 简单写法（推荐）：
    --    name = "lua",
    --    fmt = { "stylua" }
    --    -- 或 format = { "stylua" }
    -- 2) 复杂写法：
    --    format = { lua = { "stylua" }, lua_extra = { "stylua" } }
    local fmt = cfg.format or cfg.fmt
    if type(fmt) == "table" then
      if vim.islist(fmt) then
        -- 列表：按语言名或 cfg.ft 作为 filetype
        local fts = {}
        if type(cfg.ft) == "table" then
          fts = cfg.ft
        elseif type(cfg.name) == "string" then
          fts = { cfg.name }
        end
        for _, ft in ipairs(fts) do
          add_formatters(ft, fmt)
        end
      else
        -- 映射：filetype -> { "formatter1", "formatter2" }
        for ft, tools in pairs(fmt) do
          add_formatters(ft, tools)
        end
      end
    end
  end

  return {
    lsp_servers = dedup_list(lsp_servers),
    lsp_settings = lsp_settings,
    treesitter = dedup_list(ts_langs),
    formatters_by_ft = formatters_by_ft,
  }
end

return M

