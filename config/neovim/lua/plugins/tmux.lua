return {
{
	"alexghergh/nvim-tmux-navigation",
	config = function()
		require('nvim-tmux-navigation').setup({})
		vim.keymap.set("n", "<A-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
		vim.keymap.set("n", "<A-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
		vim.keymap.set("n", "<A-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
		vim.keymap.set("n", "<A-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
	end,
}
}


