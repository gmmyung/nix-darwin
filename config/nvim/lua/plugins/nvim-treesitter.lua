return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ":TSUpdate",
	main = "nvim-treesitter",
	opts = {
		install_dir = vim.fn.stdpath("data") .. "/site",
	}
}
