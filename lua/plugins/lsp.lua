local function get_lang_specs()
    local ok, lang = pcall(require, "lang")
    if not ok then
        return { lsp_servers = {}, lsp_settings = {} }
    end
    return lang.get_specs()
end

return {
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = function()
            local specs = get_lang_specs()

            -- 构建允许启动的服务器集合（白名单）
            local allowed_servers = {}
            for _, server in ipairs(specs.lsp_servers) do
                allowed_servers[server] = true
            end

            return {
                -- 根据 lang/*.lua 自动决定安装哪些 LSP
                ensure_installed = specs.lsp_servers,

                -- 配置 neovim/nvim-lspconfig
                -- 只启动 lang/*.lua 里明确配置的服务器
                handlers = {
                    function(server)
                        -- 如果不在白名单里，跳过（不启动）
                        if not allowed_servers[server] then
                            return
                        end

                        local lspconfig = require("lspconfig")
                        local server_opts = specs.lsp_settings[server] or {}

                        lspconfig[server].setup(server_opts)
                    end,
                },
            }
        end,
    },
    {
        "mason-org/mason.nvim",
        opts = {},
    },
}
