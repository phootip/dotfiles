local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- config.color_scheme = "Gruvbox Dark (Gogh)"
config.color_scheme = "Gruvbox dark, hard (base16)"
config.default_domain = "WSL:Ubuntu-22.04"
config.keys = {
	{
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1b[9;5u"),
	},
	{
		key = "Tab",
		mods = "CTRL|SHIFT ",
		action = wezterm.action.SendString("\x1b[9;6u"),
	},
}

return config
