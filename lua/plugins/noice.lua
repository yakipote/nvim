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
    -- 注意: nvim-notifyの設定は lua/plugins/notify.lua で一元管理されています
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
            -- コマンドラインをより大きく
            width = 100,
            height = "auto",
          },
          border = {
            -- 二重線のボーダー
            style = "double",
            padding = { 1, 2 },
            text = {
              top = " NERV COMMAND INTERFACE ",
              top_align = "center",
            },
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
              return string.format(" %s | TIME: %s | MAGI SYSTEM ONLINE ", id, time)
            end,
            pos = "center",
          },
          -- コマンドラインの装飾
          zindex = 200,
          relative = "editor",
          -- 入力前のプレフィックス
          buf_options = {
            filetype = "nervcmd",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 12,
            col = "50%",
          },
          size = {
            width = 100,
            height = 15,
          },
          border = {
            style = "single",
            padding = { 1, 2 },
            text = {
              top = " NERV OPTIONS ",
              top_align = "center",
            },
          },
          win_options = {
            winhighlight = {
              Normal = "NormalFloat",
              FloatBorder = "FloatBorder",
              CursorLine = "PmenuSel",
            },
            cursorline = true,
            cursorlineopt = "both",
          },
          -- 選択項目の装飾
          entry_formatter = function(menu_item)
            local nerv_id = string.format("NERV-%03d", math.random(1, 999))
            return string.format("[%s] %s", nerv_id, menu_item.text)
          end,
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
          -- 通知のスタイル
          on_open = function(win)
            -- 通知ウィンドウのオプションを設定
            vim.api.nvim_win_set_option(win, "winblend", 0)  -- 透明度なし
            -- ウィンドウの背景色を設定
            vim.api.nvim_win_set_option(win, "winhighlight", "Normal:NormalFloat,FloatBorder:FloatBorder")
          end,
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
              style = "double",
              padding = { 1, 2 },
              text = {
                top = " NERV MAGI SYSTEM ",
                top_align = "center",
              },
            },
            position = {
              row = 2,
              col = "100%",
            },
            size = {
              width = "auto",
              height = "auto",
            },
            win_options = {
              winblend = 0,
              winhighlight = {
                Normal = "NormalFloat",
                FloatBorder = "FloatBorder",
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
              style = "double",
              padding = { 1, 2 },
              text = {
                top = " COMMAND OUTPUT ",
                top_align = "center",
              },
            },
            position = {
              row = -2,
              col = "50%",
            },
            size = {
              width = 100,
              height = "auto",
            },
            win_options = {
              winblend = 0,
              winhighlight = {
                Normal = "NormalFloat",
                FloatBorder = "FloatBorder",
              },
            },
            format = function(message)
              local nerv_id = string.format("NERV-%05d", math.random(1, 99999))
              local time = os.date("%H:%M:%S")
              return string.format("[%s | %s] %s", nerv_id, time, message)
            end,
          },
        },
      },
      -- NERV風のフォーマット設定
      format = {
        -- LSP進捗状況のフォーマット
        progress = {
          title = function(client_name)
            local id = string.format("NERV-%05d", math.random(1, 99999))
            local time = os.date("%H:%M:%S")
            return string.format("[%s | %s] %s", id, time, client_name:upper())
          end,
          message = function(progress)
            if progress.message then
              return string.format("STATUS: %s", progress.message:upper())
            end
            return "STATUS: PROCESSING..."
          end,
          -- 進捗状況のフォーマット
          format = function(message, title)
            local separator = string.rep("─", 50)
            return string.format("%s\n%s\n%s", title, separator, message)
          end,
          -- 進捗状況のアイコン
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        },
        -- コマンドラインのフォーマット
        cmdline = {
          pattern = "^:",
          icon = "▶",
          lang = "vim",
          title = "Command",
          format = function(content)
            local time = os.date("%H:%M:%S")
            return string.format("[TIME: %s] %s", time, content)
          end,
        },
        -- 検索のフォーマット
        search_down = {
          view = "cmdline",
          pattern = "^/",
          icon = "🔍",
          lang = "regex",
          title = "Search",
          format = function(content)
            local nerv_id = string.format("NERV-%03d", math.random(1, 999))
            return string.format("[%s] SEARCH: %s", nerv_id, content)
          end,
        },
        search_up = {
          view = "cmdline",
          pattern = "^%?",
          icon = "🔍",
          lang = "regex",
          title = "Search",
          format = function(content)
            local nerv_id = string.format("NERV-%03d", math.random(1, 999))
            return string.format("[%s] REVERSE SEARCH: %s", nerv_id, content)
          end,
        },
      },
    })

    -- NERV風のハイライトグループを設定（nvim-notifyの設定は notify.lua で行う）
    vim.defer_fn(function()
      -- noice.nvimのハイライトグループをNERV風に設定
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = nerv_colors.nerv_orange, bg = nerv_colors.black })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = nerv_colors.nerv_yellow, bg = nerv_colors.black, bold = true })
      vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = nerv_colors.nerv_green, bg = nerv_colors.black })
      vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { fg = nerv_colors.nerv_blue, bg = nerv_colors.black })
      
      -- Noiceの通知本文のハイライトを設定
      vim.api.nvim_set_hl(0, "NoicePopupmenuMatch", { fg = nerv_colors.nerv_orange, bold = true })
      vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { bg = nerv_colors.bg, fg = nerv_colors.nerv_yellow, bold = true })
      vim.api.nvim_set_hl(0, "NoiceLspProgressTitle", { fg = nerv_colors.nerv_blue, bg = nerv_colors.black })
      vim.api.nvim_set_hl(0, "NoiceLspProgressClient", { fg = nerv_colors.nerv_green, bg = nerv_colors.black })
      vim.api.nvim_set_hl(0, "NoiceLspProgressSpinner", { fg = nerv_colors.nerv_orange, bg = nerv_colors.black })
      
      -- 通知のテキスト色を設定
      vim.api.nvim_set_hl(0, "NoiceText", { fg = nerv_colors.fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "NoicePopupMenu", { fg = nerv_colors.fg, bg = nerv_colors.black })
      vim.api.nvim_set_hl(0, "NoicePopupMenuSelected", { fg = nerv_colors.nerv_yellow, bg = nerv_colors.bg, bold = true })
    end, 100)
  end,
}
