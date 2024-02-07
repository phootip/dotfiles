-- sandwich
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

-- telescope
vim.keymap.set("", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- harpoon
local harpoon = require("harpoon")
-- require("telescope").load_extension("harpoon")
vim.keymap.set('n', '<leader>ha', function() harpoon:list():append() end)
vim.keymap.set('n', '<leader>hn', function() harpoon:list():next() end)
vim.keymap.set('n', '<leader>hp', function() harpoon:list():prev() end)
vim.keymap.set('n', '<leader>he', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
