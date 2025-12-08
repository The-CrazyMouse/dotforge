-- ===============================
-- Neovim Basic Configuration
-- ===============================

-- Set leader key to space for custom key mappings
vim.g.mapleader = " "  

-- ===============================
-- Cursor & Display Settings
-- ===============================

-- Use a block cursor instead of the fancy GUI cursor styles
vim.opt.guicursor = ""  

-- Show absolute line numbers and relative line numbers
vim.opt.nu = true             -- Absolute line number on the current line
vim.opt.relativenumber = true -- Relative line numbers on other lines

-- Highlight the line where the cursor is
vim.opt.cursorline = true  

-- Disable mode display in the command line if using statusline plugins
-- vim.opt.showmode = false  

-- ===============================
-- Indentation Settings
-- ===============================

-- Set tab-related options
vim.opt.tabstop = 4       -- Number of spaces that a tab counts for
vim.opt.shiftwidth = 4    -- Number of spaces to use for autoindent
vim.opt.expandtab = false -- Use actual tabs, not spaces

-- Enable smart indentation based on syntax
vim.opt.smartindent = true  

-- ===============================
-- Line Wrapping Settings
-- ===============================

-- Don't wrap lines by default
vim.opt.wrap = false  

-- Indent wrapped lines (only works if wrap is true)
vim.opt.breakindent = false  

-- ===============================
-- Whitespace Visualization (Optional)
-- ===============================

-- Show hidden characters like tabs, trailing spaces, and non-breaking spaces
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- ===============================
-- Search & Substitution Settings
-- ===============================

-- Preview substitutions live in a split window
vim.opt.inccommand = 'split'  

-- Highlight matches during search
vim.opt.hlsearch = false       -- Disable permanent highlighting after search
vim.opt.incsearch = true       -- Highlight matches while typing search

-- Clear search highlights with <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- ===============================
-- Undo & Backup Settings
-- ===============================

-- Disable swapfile and backup
vim.opt.swapfile = false
vim.opt.backup = false

-- Enable persistent undo with a dedicated directory
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  
vim.opt.undofile = true  

-- ===============================
-- Colors & UI Enhancements
-- ===============================

-- Enable true colors for better theme support
vim.opt.termguicolors = true  

-- Always show the sign column to prevent text shifting
vim.opt.signcolumn = "yes"  

-- Append characters to 'isfname' to recognize them in file paths
vim.opt.isfname:append("@-@")  

-- Set scroll offset to keep cursor away from edges
vim.opt.scrolloff = 8  

-- Faster completion and update times (reduces lag)
vim.opt.updatetime = 50  

-- Highlight column at 80 characters for code style guides
vim.opt.colorcolumn = "80"  

-- ===============================
-- Key Mappings
-- ===============================

-- Disable arrow keys in normal mode to enforce hjkl usage
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- ===============================
-- Highlight Yanked Text
-- ===============================

-- Autocommand to highlight yanked text briefly
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight text when yanked',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
