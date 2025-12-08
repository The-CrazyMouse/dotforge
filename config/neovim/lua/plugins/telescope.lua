return {
    {'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    "nvim-tree/nvim-web-devicons",
			{
				'nvim-telescope/telescope-ui-select.nvim',
				config = function()
					require("telescope").setup({
						extensions = {
							["ui-select"] = {
								require("telescope.themes").get_dropdown {
								}
							}
						}
					})
					require("telescope").load_extension("ui-select")
					require("telescope").load_extension("fzf")
				end
			},
},
config = function()
    local builtin = require('telescope.builtin')
    -- some keybinding aswell
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
	vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>ps', function()
       builtin.grep_string({ search = vim.fn.input("Grep > ")})
    end)
end
},
}

