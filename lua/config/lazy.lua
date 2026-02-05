require("core.lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "onedark", "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
