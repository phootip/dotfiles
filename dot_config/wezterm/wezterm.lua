local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

wezterm.on("increase-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.85
	elseif overrides.window_background_opacity <= 1 then
		overrides.window_background_opacity = overrides.window_background_opacity + 0.05
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("decrease-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.85
	elseif overrides.window_background_opacity >= 0 then
		overrides.window_background_opacity = overrides.window_background_opacity - 0.05
	end
	window:set_config_overrides(overrides)
end)

-- config.color_scheme = "Gruvbox Dark (Gogh)"
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Dracula (Official)"
-- config.default_domain = "WSL:Ubuntu-22.04"
config.debug_key_events = true
config.disable_default_key_bindings = true
config.hide_tab_bar_if_only_one_tab = true
config.send_composed_key_when_right_alt_is_pressed = false
config.window_background_opacity = 0.85
-- config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
-- config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = true })
-- config.font = wezterm.font("Source Code Pro")
config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono")
-- config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Bold" })
config.font_size = 15
config.default_cursor_style = "BlinkingBlock"
-- config.cursor_blink_rate = 800
-- config.cursor_blink_ease_in = "Constant"
-- config.cursor_blink_ease_out = "Constant"
config.colors = {
	cursor_bg = "#d466d8",
	-- cursor_bg = "#ff0000",
}
config.keys = {
	-- change tab
	-- { key = "]", mods = "SUPER|SHIFT", action = "DisableDefaultAssignment" },
	-- { key = "}", mods = "SUPER|SHIFT", action = "DisableDefaultAssignment" },
	-- { key = "}", mods = "SUPER", action = "DisableDefaultAssignment" },
	-- { key = "[", mods = "SUPER|SHIFT", action = "DisableDefaultAssignment" },
	-- { key = "{", mods = "SUPER|SHIFT", action = "DisableDefaultAssignment" },
	-- { key = "{", mods = "SUPER", action = "DisableDefaultAssignment" },
	{ key = "}", mods = "SUPER|SHIFT", action = act.SendKey({ key = "o", mods = "ALT" }) },
	{ key = "{", mods = "SUPER|SHIFT", action = act.SendKey({ key = "y", mods = "ALT" }) },
	-- { key = "y", mods = "ALT", action = act.SendKey({ key = "y", mods = "ALT" }) },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "SUPER", action = act.DecreaseFontSize },
	{ key = "=", mods = "SUPER", action = act.IncreaseFontSize },
	{ key = "LeftArrow", mods = "SUPER", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "RightArrow", mods = "SUPER", action = act.SendKey({ key = "e", mods = "CTRL" }) },
	{ key = "Backspace", mods = "SUPER", action = act.SendKey({ key = "u", mods = "CTRL" }) },
	{ key = "Delete", mods = "SUPER", action = act.SendKey({ key = "d", mods = "ALT" }) },
	{ key = "Delete", mods = "ALT", action = act.SendKey({ key = "d", mods = "ALT" }) },
	{ key = "LeftArrow", mods = "ALT", action = act.SendKey({ key = "b", mods = "ALT" }) },
	{ key = "RightArrow", mods = "ALT", action = act.SendKey({ key = "f", mods = "ALT" }) },
	{ key = "Delete", mods = "ALT", action = act.SendKey({ key = "d", mods = "ALT" }) },
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
	-- { key = "z", mods = "SUPER", action = act.SendKey({ key = "y", mods = "CTRL" }) },
	{ key = "z", mods = "CTRL", action = act.SendKey({ key = "y", mods = "CTRL" }) },
	{ key = ",", mods = "CTRL", action = act.EmitEvent("decrease-opacity") },
	{ key = ".", mods = "CTRL", action = act.EmitEvent("increase-opacity") },
	{ key = "9", mods = "CTRL", action = act.EmitEvent("decrease-opacity") },
	{ key = "0", mods = "CTRL", action = act.EmitEvent("increase-opacity") },
}

return config
