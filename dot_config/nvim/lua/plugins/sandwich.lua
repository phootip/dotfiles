return {
	{
		"machakann/vim-sandwich",
		event = "VeryLazy",
		init = function()
			vim.g.sandwich_no_default_key_mappings = 1
		end,
		keys = {
			{ "gsa", "<Plug>(sandwich-add)", silent = true, mode = { "n", "x", "o" } },
			{ "gsr", "<Plug>(sandwich-replace)", silent = true },
			{ "gsrr", "<Plug>(sandwich-replace-auto)", silent = true },
			{ "gsc", "<Plug>(sandwich-replace)", silent = true },
			{ "gscc", "<Plug>(sandwich-replace-auto)", silent = true },
			{ "gsd", "<Plug>(sandwich-delete)", silent = true },
			{ "gsdo", "<Plug>(sandwich-delete-auto)", silent = true },
			{ "ir", "<Plug>(textobj-sandwich-auto-i)", silent = true, mode = { "x", "o" } },
			{ "ab", "<Plug>(textobj-sandwich-auto-a)", silent = true, mode = { "x", "o" } },
		},
	},
}
