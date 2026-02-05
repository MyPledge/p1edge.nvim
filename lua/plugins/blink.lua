return {
    "saghen/blink.cmp",

    -- 启动完成后，后台异步加载
    event = "VeryLazy",

    build = 'cargo build --release',
    opts = {
        keymap = {
            preset = "default",
            ["<CR>"] = { "accept", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
        },

        completion = {
            documentation = {
                auto_show = false, -- 性能优先
            },
        },

        sources = {
            default = { "lsp", "path", 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}

