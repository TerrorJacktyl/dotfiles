-- Set the leader key to space
-- Important to come before packages, because packages depends on the leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Initialise Lazy package manager
require("config.lazy")

vim.cmd("au FileType tex,plaintex,markdown,rst setlocal spelllang=en_gb spell") -- Enable spell-checking for text files

-- Toggle line numbers (absolute current, relative neighbouring) with <space>l
-- One basic keymap to test this config works when I inevitably reinstall it somewhere. Other keymaps can live in a plugin.
ToggleRelativeLineNumbers = function()
	vim.opt.number = not vim.opt.number
	vim.opt.relativenumber = not vim.opt.relativenumber
end
vim.api.nvim_set_keymap("n", "<Leader>l", "<cmd>lua ToggleRelativeLineNumbers()<cr>", {})
