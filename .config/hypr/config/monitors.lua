local host = require("config.host")

local monitors = {
	desktop = {
		output = "DP-2",
		mode = "1920x1080@144",
		position = "0x0",
		scale = "1",
	},
	laptop = {
		output = "eDP-1",
		mode = "2880x1800@120",
		position = "0x0",
		scale = "1.5",
	},
}

hl.monitor(monitors[host.profile])
