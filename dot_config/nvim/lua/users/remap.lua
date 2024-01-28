vim.keymap.set("", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.opt.clipboard = 'unnamedplus'

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "^")
vim.keymap.set("v", "L", "$")

vim.g.sandwich_no_default_key_mappings = 1
vim.keymap.set("", "<leader>sa", "<Plug>(sandwich-add)")
vim.keymap.set("", "<leader>sd", "<Plug>(sandwich-delete)")
vim.keymap.set("", "<leader>sdb", "<Plug>(sandwich-delete-auto)")
vim.keymap.set("", "<leader>sr", "<Plug>(sandwich-replace)")
vim.keymap.set("", "<leader>srb", "<Plug>(sandwich-replace-auto)")
vim.keymap.set("", "<leader>sc", "<Plug>(sandwich-replace)")
vim.keymap.set("", "<leader>scb", "<Plug>(sandwich-replace-auto)")
vim.keymap.set({ "o", "x" }, "<unique> ib", "(textobj-sandwich-auto-i)")
vim.keymap.set({ "o", "x" }, "<unique> ab", "(textobj-sandwich-auto-a)")
vim.keymap.set({ "o", "x" }, "<unique> is", "(textobj-sandwich-query-i)")
vim.keymap.set({ "o", "x" }, "<unique> as", "(textobj-sandwich-query-a)")
-- " add
-- silent! nmap <unique> sa <Plug>(sandwich-add)
-- silent! xmap <unique> sa <Plug>(sandwich-add)
-- silent! omap <unique> sa <Plug>(sandwich-add)

-- " delete
-- silent! nmap <unique> sd <Plug>(sandwich-delete)
-- silent! xmap <unique> sd <Plug>(sandwich-delete)
-- silent! nmap <unique> sdb <Plug>(sandwich-delete-auto)

-- " replace
-- silent! nmap <unique> sr <Plug>(sandwich-replace)
-- silent! xmap <unique> sr <Plug>(sandwich-replace)
-- silent! nmap <unique> srb <Plug>(sandwich-replace-auto)
-- endif

-- if !exists('g:textobj_sandwich_no_default_key_mappings')
-- " auto
-- silent! omap <unique> ib <Plug>(textobj-sandwich-auto-i)
-- silent! xmap <unique> ib <Plug>(textobj-sandwich-auto-i)
-- silent! omap <unique> ab <Plug>(textobj-sandwich-auto-a)
-- silent! xmap <unique> ab <Plug>(textobj-sandwich-auto-a)

-- " query
-- silent! omap <unique> is <Plug>(textobj-sandwich-query-i)
-- silent! xmap <unique> is <Plug>(textobj-sandwich-query-i)
-- silent! omap <unique> as <Plug>(textobj-sandwich-query-a)
-- silent! xmap <unique> as <Plug>(textobj-sandwich-query-a)
-- endif
