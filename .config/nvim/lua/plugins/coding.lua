return {
	-- Git on steroids
	{
		"tpope/vim-fugitive",
	},
	{
		-- shows context of the current cursor position at the top of the screen
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		-- ability to comment visual block
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup({
				mappings = {
					comment_visual = "<c-/>",
				},
			})
		end,
	},
	{
		-- shows current line blame & hunks from commits
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_formatter = "  <abbrev_sha> - <author>, <author_time:%Y-%m-%d> - <summary>",
		},
	},
	{
		-- enables github copilot
		"github/copilot.vim",
	},
}
