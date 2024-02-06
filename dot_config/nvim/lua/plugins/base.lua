return {
  { "nvim-lua/plenary.nvim" },
  { "christoomey/vim-tmux-navigator" },
  { "nvim-telescope/telescope.nvim", tag = '0.1.5' },
  { "ThePrimeagen/harpoon",          branch = "harpoon2" },
  { "mg979/vim-visual-multi" },
  { "machakann/vim-sandwich", event = "VeryLazy" },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
    },
  },
}
