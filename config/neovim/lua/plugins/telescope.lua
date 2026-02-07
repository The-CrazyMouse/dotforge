-- ~/.config/nvim/lua/plugins/telescope.lua  (or wherever you put it)
return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"nvim-tree/nvim-web-devicons", -- optional but nice for icons
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					-- Common sensible defaults (feel free to tweak)
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = { height = 0.95, width = 0.90, preview_width = 0.55 },
						vertical = { height = 0.95, width = 0.90, preview_width = 0.55 },
						center = { height = 0.9, width = 0.6 },
						cursor = { height = 0.9, width = 0.6 },
						bottom_pane = { height = 0.3, prompt_position = "top" },
					},
					sorting_strategy = "ascending", -- or "descending"
					prompt_prefix = "   ",
					selection_caret = "󰅂 ",
					entry_prefix = "  ",
					border = true,
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }, -- thin rounded like your cmp
					mappings = {
						i = {
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
							["<C-q>"] = "send_to_qflist",
						},
					},
					-- If you have ripgrep installed (highly recommended)
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden", -- search dotfiles too
						"--glob=!.git/",
					},
				},

				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- Make it match your Everforest / cmp style
							borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
							winblend = 0,
							previewer = false,
							prompt = " ",
						}),
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})

			-- Load extensions
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")

			-- Keymaps (your existing ones + a few very common extras)
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
			vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Grep string" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

			-- Very useful extras (add if you like them)
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
			-- LSP pickers (once LSP is attached)
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
			vim.keymap.set("n", "<leader>fS", builtin.lsp_dynamic_workspace_symbols, { desc = "Workspace symbols" })
		end,
	},
}
