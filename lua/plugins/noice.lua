-- lazy.nvim
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    -- NERV風の色を定義
    local nerv_colors = {
      bg = "#0e0e18",           -- Dark blue-black background
      fg = "#f0f0c0",           -- Light yellow-green text
      black = "#000000",        -- Pure black
      nerv_orange = "#ff6600",  -- NERV logo orange
      nerv_yellow = "#ffcc33",  -- NERV console yellow
      nerv_red = "#ff3333",     -- NERV alert red
      nerv_green = "#00ff66",   -- NERV terminal green
      nerv_blue = "#3399ff",    -- NERV interface blue
    }

    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      -- NERV風のスタイルを適用
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "single",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = {
              Normal = "NormalFloat",
              FloatBorder = "FloatBorder",
              CursorLine = "PmenuSel",
            },
          },
          -- NERV風のタイトルを追加
          title = {
            text = function()
              local id = string.format("NERV-%05d", math.random(1, 99999))
              local time = os.date("%H:%M:%S")
              return string.format(" %s | TIME: %s ", id, time)
            end,
            pos = "center",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "single",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = {
              Normal = "NormalFloat",
              FloatBorder = "FloatBorder",
              CursorLine = "PmenuSel",
            },
          },
        },
        -- NERV風の通知スタイル
        notify = {
          -- nvim-notifyを使用
          backend = "notify",
          -- 通知の透明度
          transparency = 0,
          -- 通知の最大幅
          max_width = 80,
          -- 通知の最大高さ
          max_height = 20,
          -- 通知の表示時間
          timeout = 3000,
          -- 通知のレベル
          level = "info",
        },
        -- NERV風のメッセージスタイル
        messages = {
          -- メッセージの表示位置
          view = "notify",
          -- メッセージの表示時間
          timeout = 3000,
        },
      },
      -- NERV風のルート設定
      routes = {
        -- LSP進捗状況をNERV風に表示
        {
          filter = { event = "lsp.progress" },
          view = "mini",
          opts = {
            title = "NERV-LSP",
            border = {
              style = "single",
              padding = { 0, 1 },
              text = {
                top = " NERV SYSTEM ",
                top_align = "center",
              },
            },
          },
        },
        -- コマンド出力をNERV風に表示
        {
          filter = { event = "msg_show", kind = { "command" } },
          opts = {
            title = "NERV-CMD",
            border = {
              style = "single",
              padding = { 0, 1 },
              text = {
                top = " COMMAND OUTPUT ",
                top_align = "center",
              },
            },
          },
        },
      },
      -- NERV風のフォーマット設定
      format = {
        -- LSP進捗状況のフォーマット
        progress = {
          title = function(client_name)
            local id = string.format("NERV-%05d", math.random(1, 99999))
            return string.format("[%s] %s", id, client_name)
          end,
          message = function(progress)
            if progress.message then
              return progress.message
            end
            return "PROCESSING..."
          end,
        },
      },
    })

    -- nvim-notifyの設定を上書きしないように、NERV-themeの設定後に実行
    vim.defer_fn(function()
      -- noice.nvimのハイライトグループをNERV風に設定
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = nerv_colors.nerv_orange, bg = nerv_colors.black })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = nerv_colors.nerv_yellow, bg = nerv_colors.black, bold = true })
      vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = nerv_colors.nerv_green, bg = nerv_colors.black })
      vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { fg = nerv_colors.nerv_blue, bg = nerv_colors.black })
    end, 100)
  end,
}
