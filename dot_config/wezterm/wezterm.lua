local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- config.color_scheme = "Gruvbox Dark (Gogh)"
config.color_scheme = "Gruvbox dark, hard (base16)"
-- config.default_domain = "WSL:Ubuntu-22.04"
config.debug_key_events = true
config.disable_default_key_bindings = true
config.hide_tab_bar_if_only_one_tab = true
config.send_composed_key_when_right_alt_is_pressed = false
config.keys = {
	-- change tab
	-- { key = "]", mods = "SUPER|SHIFT", action = "DisableDefaultAssignment" },
	-- { key = "}", mods = "SUPER|SHIFT", action = "DisableDefaultAssignment" },
	-- { key = "}", mods = "SUPER", action = "DisableDefaultAssignment" },
	-- { key = "[", mods = "SUPER|SHIFT", action = "DisableDefaultAssignment" },
	-- { key = "{", mods = "SUPER|SHIFT", action = "DisableDefaultAssignment" },
	-- { key = "{", mods = "SUPER", action = "DisableDefaultAssignment" },
	{ key = "}", mods = "SUPER|SHIFT", action = act.SendKey({ key = "o", mods = "ALT" }) },
	{ key = "{", mods = "SUPER|SHIFT", action = act.SendKey({ key = "i", mods = "ALT" }) },
}

return config
