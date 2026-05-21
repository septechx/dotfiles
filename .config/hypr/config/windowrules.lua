hl.window_rule({
	match = {
		class = "waypaper",
	},
	float = true,
})

hl.window_rule({
	match = {
		title = "Astatine",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "FloatInput",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})
