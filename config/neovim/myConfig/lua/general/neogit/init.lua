require('lz.n').load {
	{
		"neogit", cmd = "Neogit",
		after = function()
			require('neogit').setup {}
		end
	},
}
