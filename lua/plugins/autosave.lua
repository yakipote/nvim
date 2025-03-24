return {
  "yakipote/autosave.nvim",
  lazy = false,
  config = function()
    -- NERV風の自動保存通知を設定
    local function nerv_notify(msg)
      local nerv_id = string.format("NERV-%05d", math.random(1, 99999))
      local time = os.date("%H:%M:%S")
      local title = "NERV AUTO SAVE"
      
      -- NERV風のメッセージに変換
      local nerv_msg = string.format("ファイル保存完了\n保存時刻: %s\n\n%s", time, msg)
      
      -- 通知を表示
      vim.notify(nerv_msg, vim.log.levels.INFO, {
        title = title,
        timeout = 2000,
      })
    end
    
    -- autosaveプラグインの設定
    require("autosave").setup({
      save_interval = 1000,
      -- NERV風の通知関数を設定
      notify_callback = nerv_notify,
    })
  end,
}
