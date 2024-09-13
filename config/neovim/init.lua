-- Set the leader key to space
-- Important to come before packages, because packages depends on the leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Initialise Lazy package manager
require("config.lazy")

-- General configuration
------------------------
local o = vim.opt

-- Editor options

o.clipboard = "unnamedplus" -- uses the clipboard register for all operations except yank.
o.cursorline = true -- Highlight the screen line of the cursor with CursorLine.
o.encoding = "UTF-8" -- Sets the character encoding used inside Vim.
o.inccommand = "split" -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
o.listchars = 'tab:>-,trail:-' -- show trailing whitespace as -, tabs as >-
o.list = true
o.mouse = "a" -- Enable the use of the mouse. "a" you can use on all modes
o.showcmd = true -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one.
o.splitbelow = true -- When on, splitting a window will put the new window below the current one
o.splitright = true
o.termguicolors = true
o.ttimeoutlen = 0 -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.

-- Unsure what these do, I just copied them from the internet lol
o.syntax = "on" -- When this option is set, the syntax with this name is loaded.
o.title = true -- When on, the title of the window will be set to the value of 'titlestring'
o.wildmenu = true -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.

-- Indentation
o.autoindent = true -- Copy indent from current line when starting a new line.
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true

-- Line numbers
o.number = true -- Print the current absolute line number in front of the cursor
o.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line.
o.ruler = true -- Show the line and column number of the cursor position, separated by a comma.

-- Undo
o.undofile = true -- Enable persistent undo
o.undodir = vim.env.HOME .. '/.vim/undodir' -- Prevent errors like "cannot open undo file for writing"

vim.cmd('au FileType tex,plaintex,markdown,rst setlocal spelllang=en_gb spell') -- Enable spell-checking for text files

-- Toggle line numbers (absolute current, relative neighbouring) with <space>l
-- One basic keymap to test this config works when I inevitably reinstall it somewhere. Other keymaps can live in a plugin.
ToggleRelativeLineNumbers = function()
  o.number = not o.number
  o.relativenumber = not o.relativenumber
end
vim.api.nvim_set_keymap('n', '<Leader>l', '<cmd>lua ToggleRelativeLineNumbers()<cr>', {noremap = true})
