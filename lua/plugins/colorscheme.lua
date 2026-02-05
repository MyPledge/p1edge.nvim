return {
  "navarasu/onedark.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    style = "dark", -- 可选: dark, darker, cool, deep, warm, warmer, light
  },
  config = function(_, opts)
    require("onedark").setup(opts)
    require("onedark").load()
  end,
}

