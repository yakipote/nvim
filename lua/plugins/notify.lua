-- nvim-notify設定
return {
  "rcarriga/nvim-notify",
  lazy = false,
  config = function()
    -- NERV風のカスタム通知レンダラーを定義
    local nerv_renderer = function(bufnr, notif, highlights, config)
      local namespace = vim.api.nvim_create_namespace("nerv_notify")
      local icon = config.icons[notif.level] or "■"
      local nerv_id = string.format("NERV-%05d", math.random(1, 99999))
      local timestamp = os.date("%H:%M:%S")
      
      -- 通知の幅を計算（より大きく）
      local width = math.min(120, vim.o.columns)
      
      -- タイトル行
      local title = notif.title or "NERV SYSTEM"
      local title_line = string.format(" %s %s | %s ", icon, nerv_id, title:upper())
      vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, { title_line })
      
      -- タイトルのハイライト
      local title_hl = highlights.title[notif.level]
      vim.api.nvim_buf_add_highlight(bufnr, namespace, title_hl, 0, 0, -1)
      
      -- 上部区切り線（二重線）
      local separator = string.rep("═", width - 2)
      vim.api.nvim_buf_set_lines(bufnr, 1, 2, false, { separator })
      vim.api.nvim_buf_add_highlight(bufnr, namespace, title_hl, 1, 0, -1)
      
      -- ステータス行
      local status_line = string.format(" STATUS: ACTIVE | TIME: %s | LEVEL: %s ", timestamp, notif.level)
      vim.api.nvim_buf_set_lines(bufnr, 2, 3, false, { status_line })
      vim.api.nvim_buf_add_highlight(bufnr, namespace, title_hl, 2, 0, -1)
      
      -- 中間区切り線（シングル）
      local mid_separator = string.rep("─", width - 2)
      vim.api.nvim_buf_set_lines(bufnr, 3, 4, false, { mid_separator })
      vim.api.nvim_buf_add_highlight(bufnr, namespace, title_hl, 3, 0, -1)
      
      -- メッセージ本文
      local body_start_line = 4
      if notif.message then
        local message_lines = {}
        
        -- メッセージが文字列の場合は配列に変換
        if type(notif.message) == "string" then
          -- 改行で分割
          for line in string.gmatch(notif.message, "[^\r\n]+") do
            table.insert(message_lines, line)
          end
        else
          -- 既に配列の場合はそのまま使用
          for i, line in ipairs(notif.message) do
            table.insert(message_lines, line)
          end
        end
        
        -- 各行の前後に余白を追加
        for i, line in ipairs(message_lines) do
          message_lines[i] = " " .. line .. " "
        end
        
        -- 空行を追加して余白を作る
        table.insert(message_lines, 1, "")
        table.insert(message_lines, "")
        
        vim.api.nvim_buf_set_lines(bufnr, body_start_line, body_start_line + #message_lines, false, message_lines)
        
        -- 本文のハイライト
        local body_hl = highlights.body[notif.level]
        for i = 0, #message_lines - 1 do
          vim.api.nvim_buf_add_highlight(bufnr, namespace, body_hl, body_start_line + i, 0, -1)
        end
        
        body_start_line = body_start_line + #message_lines
      end
      
      -- 下部区切り線（二重線）
      vim.api.nvim_buf_set_lines(bufnr, body_start_line, body_start_line + 1, false, { separator })
      vim.api.nvim_buf_add_highlight(bufnr, namespace, title_hl, body_start_line, 0, -1)
      
      -- フッター行
      local footer_line = " NERV CENTRAL DOGMA | TERMINAL ACCESS GRANTED "
      vim.api.nvim_buf_set_lines(bufnr, body_start_line + 1, body_start_line + 2, false, { footer_line })
      vim.api.nvim_buf_add_highlight(bufnr, namespace, title_hl, body_start_line + 1, 0, -1)
    end
    
    -- NERV-themeの設定に加えて、追加の設定を行う
    require("notify").setup({
      -- 背景色を黒に設定
      background_colour = "#000000",
      -- 通知の表示時間
      timeout = 5000,
      -- 通知の最大幅（大きく設定）
      max_width = 120,
      -- 通知の最大高さ（大きく設定）
      max_height = 40,
      -- 通知のレンダリングスタイル
      render = nerv_renderer,
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
      -- 通知の余白
      padding = 2,
      -- 通知の間隔
      spacing = 3,
    })
    
    -- 通知のハイライトグループを設定
    vim.defer_fn(function()
      -- 文字色を明るく設定して見やすくする（コントラストを強化）
      vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = "#ffffff", bg = "#000000" })
      vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = "#ffffff", bg = "#000000" })
      vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = "#ffffff", bg = "#000000" })
      vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = "#ffffff", bg = "#000000" })
      vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = "#ffffff", bg = "#000000" })
      
      -- 通知のタイトル色も設定（より明るく）
      vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = "#ff5555", bg = "#000000", bold = true })
      vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = "#ffdd55", bg = "#000000", bold = true })
      vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = "#55ff88", bg = "#000000", bold = true })
      vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = "#55aaff", bg = "#000000", bold = true })
      vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = "#aa55ff", bg = "#000000", bold = true })
      
      -- ボーダーの色も設定（より明るく）
      vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = "#ff5555", bg = "#000000" })
      vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = "#ffdd55", bg = "#000000" })
      vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = "#55ff88", bg = "#000000" })
      vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = "#55aaff", bg = "#000000" })
      vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = "#aa55ff", bg = "#000000" })
    end, 100)
    
    -- テスト通知を表示する関数を定義（デバッグ用）
    _G.show_nerv_test_notification = function()
      vim.notify("エヴァンゲリオン初号機、起動準備完了\nシンクロ率 41.3%\n\n第3新東京市、現在時刻 " .. os.date("%H:%M:%S"), 
        vim.log.levels.INFO, 
        { title = "NERV本部" })
    end
    
    -- キーマップを設定（オプション）
    vim.keymap.set("n", "<Leader>nt", function() _G.show_nerv_test_notification() end, 
      { desc = "NERV風テスト通知を表示" })
  end,
}