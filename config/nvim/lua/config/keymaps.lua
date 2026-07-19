-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Capture mouse scrolling for vim so that the terminal still permits scrolling
vim.keymap.set("n", "<ScrollWheelDown>", "j")
vim.keymap.set("n", "<ScrollWheelUp>", "k")
