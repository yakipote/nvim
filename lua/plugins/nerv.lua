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
      -- NERV-themeの設定に加えて、追加の設定を行う
      require("notify").setup({
        -- 背景色を黒に設定
        background_colour = "#000000",
        -- 通知の表示時間
        timeout = 3000,
        -- 通知の最大幅
        max_width = 80,
        -- 通知の最大高さ
        max_height = 20,
        -- 通知のレンダリングスタイル
        render = "default",
        -- 通知のスタイル
        stages = "static",
        -- 通知のアイコン
        icons = {
          ERROR = "▲",
          WARN = "▲",
          INFO = "■",
          DEBUG = "●",
          TRACE = "◆",
        },
        -- 通知のレベル別の色
        level = {
          colors = {
            ERROR = "#ff3333", -- NERV赤
            WARN = "#ffcc33",  -- NERV黄
            INFO = "#00ff66",  -- NERV緑
            DEBUG = "#3399ff", -- NERV青
            TRACE = "#9933ff", -- 紫
          },
        },
        -- 通知の表示位置
        top_down = true,
      })
      
      -- 通知のハイライトグループを設定
      vim.defer_fn(function()
        -- 文字色を明るく設定して見やすくする
        vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = "#f0f0c0", bg = "#000000" })
        vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = "#f0f0c0", bg = "#000000" })
        vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = "#f0f0c0", bg = "#000000" })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = "#f0f0c0", bg = "#000000" })
        vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = "#f0f0c0", bg = "#000000" })
        
        -- 通知のタイトル色も設定
        vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = "#ff3333", bg = "#000000", bold = true })
        vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = "#ffcc33", bg = "#000000", bold = true })
        vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#00ff66", bg = "#000000", bold = true })
        vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = "#3399ff", bg = "#000000", bold = true })
        vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = "#9933ff", bg = "#000000", bold = true })
      end, 100)
    end,
  },
}
