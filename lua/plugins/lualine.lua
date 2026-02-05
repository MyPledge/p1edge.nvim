return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- 状态栏 / tabline 属于基础 UI，启动时立即加载
    lazy = false,

    -- 与 lualine 强相关的快捷键放在这里
    keys = {
        {
            "<S-l>",
            "<cmd>bnext<cr>",
            desc = "Buffer: next",
        },
        {
            "<S-h>",
            "<cmd>bprevious<cr>",
            desc = "Buffer: previous",
        },
        {
            "<leader>bd",
            "<cmd>bdelete<cr>",
            desc = "Buffer: delete",
        },
    },

    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            -- 在 Neovim 0.9+ 建议启用全局状态栏
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },

        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = {
                {
                    "filename",
                    path = 1, -- 相对路径，更易分辨文件位置
                    symbols = {
                        modified = "●",
                        readonly = "",
                        unnamed = "[No Name]",
                    },
                },
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },

        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },

        -- 用 lualine 自带的 tabline 管理 buffer / tab
        tabline = {
            lualine_a = {
                {
                    "buffers",
                    mode = 2, -- 显示 buffer 编号 + 名称
                    show_filename_only = true,
                    symbols = {
                        modified = "●",
                        alternate_file = "#",
                        directory = "",
                    },
                },
            },
            lualine_z = { "tabs" },
        },

        winbar = {},
        inactive_winbar = {},
        extensions = {},
    },
}
