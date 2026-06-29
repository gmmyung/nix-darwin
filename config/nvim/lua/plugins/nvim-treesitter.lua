return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ":TSUpdate",
	main = "nvim-treesitter",
	opts = {
		install_dir = vim.fn.stdpath("data") .. "/site",
	},
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
