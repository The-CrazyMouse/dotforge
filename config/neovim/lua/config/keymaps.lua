-- Space is Leader
vim.g.mapleader = " "

-- Get to file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Moving lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Joins the line bellow ir to the end of the current line
vim.keymap.set("n", "J", "mzJ`z")

-- When navigating search results with n (next match) or N (previous match)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Past without overwriting
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copies to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deletes stuff to the void (doesn't overwriting register or clipboard)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Disables Ex mode
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Quickfix Navigation
--
-- Quickfix List
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- Location List
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Open neovim config
vim.keymap.set("n", "<leader>nc", "<cmd>e ~/.dotforge/config/neovim/init.lua<CR>", { desc = "Open Neovim Configuration" })

-- Make File Executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make Current File Executable" })
