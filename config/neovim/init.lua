-- Set the leader key to space
-- Important to come before packages, because packages depends on the leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require('packages')

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

-- Key mappings
---------------
local wk = require("which-key")
-- As an example, we will create the following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1

wk.register({
  f = {
    name = "file", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap=false }, -- additional options for creating the keymap
    n = { "New File" }, -- just a label. don't create any mapping
    e = "Edit File", -- same as above
    ["1"] = "which_key_ignore",  -- special label to hide it in the popup
    b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
  },
}, { prefix = "<leader>" })

-- TODO: Move to which-key
-----------

-- Clear search highlighting with <space>,
-- vim.api.nvim_set_keymap('n', '<leader>,', ':noh<cr>', { silent = true})
-- test
vim.api.nvim_set_keymap('n', '<esc>', ':noh<cr>', { silent = true })

-- Scroll up and down visible lines, not buffer lines, with j and k
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})

-- Navigate tabs with shift-{h,l}
vim.api.nvim_set_keymap('n', '<S-l>', 'gt', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-h>', 'gT', {noremap = true})

-- Navigate splits with control-{h,j,k,l}
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})

-- Create horizontal (<space>-) and vertical (<space>|) splits
vim.api.nvim_set_keymap('n', '<Leader>-', ':split<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>|', ':vsplit<cr>', {noremap = true})

-- Quickly save, quit, or save-and-quit
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>q', ':q<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>x', ':x<cr>', {})

