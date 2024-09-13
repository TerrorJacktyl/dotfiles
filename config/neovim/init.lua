-- Set the leader key to space
-- Important to come before packages, because packages depends on the leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Initialise Lazy package manager
require("config.lazy")

-- General configuration
------------------------

-- Enable persistent undo
vim.o.undofile = true
-- Prevent errors like "cannot open undo file for writing"
vim.o.undodir = vim.env.HOME .. '/.vim/undodir'

-- Enable the mouse in the terminal
vim.o.mouse = 'a'

-- UI
-----

-- Theme
-- vim.cmd[[colorscheme catppuccin]]

-- Have some context around the current line always on screen
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5

-- show trailing whitespace as -, tabs as >-
vim.o.listchars = 'tab:>-,trail:-'
vim.o.list = true

-- Live substitution
vim.o.inccommand = 'split'
--
-- Toggle line numbers (absolute current, relative neighbouring) with <space>l
ToggleRelativeLineNumbers = function()
  vim.o.number = not vim.o.number
  vim.o.relativenumber = not vim.o.relativenumber
end
vim.api.nvim_set_keymap('n', '<Leader>l', '<cmd>lua ToggleRelativeLineNumbers()<cr>', {noremap = true})
vim.o.number = true -- Start with absolute current
vim.o.relativenumber = true -- Start with relative line numbers

-- Coding style
---------------

-- Tabs as two spaces
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Enable spell-checking for text files
vim.cmd('au FileType tex,plaintex,markdown,rst setlocal spelllang=en_gb spell')


