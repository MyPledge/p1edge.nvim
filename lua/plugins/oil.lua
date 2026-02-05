return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} }, {"nvim-tree/nvim-web-devicons"} },
  cmd = "Oil",
  keys = {
    {
      "<leader>o",
      "<cmd>Oil<cr>",
      desc = "Oil: current file dir",
    },
    {
      "<leader>O",
      "<cmd>Oil .<cr>",
      desc = "Oil: CWD",
    },
  },
}
