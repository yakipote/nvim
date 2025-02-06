-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Insertモードで 'jj' または 'kk' を押すとESCキーにマップ
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kk", "<ESC>", { noremap = true, silent = true })

local map = vim.keymap.set

local uname = vim.uv.os_uname()
print(uname.sysname)

-- macos用の設定
if uname.sysname == "Darwin" then
  -- Resize window using <ctrl> arrow keys
  map("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
  map("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
  map("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
  map("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
end
