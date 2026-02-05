return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },

  cmd = "Telescope",
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Telescope: find files",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Telescope: live grep",
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Telescope: buffers",
    },
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Telescope: help tags",
    },
    {
      "<leader>fd",
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "Telescope: diagnostics",
    },
    {
      "<leader>fr",
      function()
        require("telescope.builtin").lsp_references()
      end,
      desc = "Telescope: LSP references",
    },
  },

  opts = function()
    local telescope = require("telescope")

    local defaults = {
      prompt_prefix = "   ",
      selection_caret = "❯ ",
      sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
      },
      path_display = { "smart" },
      dynamic_preview_title = true,
    }

    -- 性能：优先使用 fzf-native
    local extensions = {}
    pcall(function()
      telescope.load_extension("fzf")
      extensions.fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    end)

    return {
      defaults = defaults,
      extensions = extensions,
    }
  end,
}

