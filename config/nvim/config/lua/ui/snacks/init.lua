require('snacks').setup {
	animate = {
		enabled = true,
		style = "out",
		easing = "linear",
		duration = {
			step = 20, -- ms per step
			total = 2000, -- maximum duration
		},
	},
	indent = {
		enabled = true,
	},
	scroll = {}
}
