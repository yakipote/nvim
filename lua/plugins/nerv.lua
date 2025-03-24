return {
  {
    "yakipote/nerv-theme.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- nvim-notify
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      -- NERV-themeが自動的に設定するので、ここでは何もする必要はありません
    end,
  },
}
