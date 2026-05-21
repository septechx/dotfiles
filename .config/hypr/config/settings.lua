hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 16,
		border_size = 2,
		col = {
			active_border = "rgba(a9b1d6ff)",
			inactive_border = "rgba(1a1b26ff)",
		},
		resize_on_border = false,
		allow_tearing = true,
		layout = "dwindle",
	},
	decoration = {
		rounding = 8,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		blur = {
			enabled = true,
			size = 8,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	dwindle = {
		pseudotile = true,
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		font_family = "JetBrainsMono Nerd Font",
	},
	render = {
		direct_scanout = true,
	},
})
