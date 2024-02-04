vim.keymap.set("", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.opt.clipboard = 'unnamedplus'

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set({"n","v"}, "H", "^")
vim.keymap.set({"n","v"}, "L", "$")
