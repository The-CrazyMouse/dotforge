-- ~/.config/nvim/lua/plugins/harpoon.lua
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- Basic setup (required)
    harpoon:setup()

    -- Keybindings (feel free to change)
    local key = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Add current file to the list
    key("n", "<leader>a", function() harpoon:list():add() end, opts)

    -- Toggle quick menu (or use Telescope version below)
    key("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)

    -- Quick jump to marks 1-9
    key("n", "<leader>1", function() harpoon:list():select(1) end, opts)
    key("n", "<leader>2", function() harpoon:list():select(2) end, opts)
    key("n", "<leader>3", function() harpoon:list():select(3) end, opts)
    key("n", "<leader>4", function() harpoon:list():select(4) end, opts)
    key("n", "<leader>5", function() harpoon:list():select(5) end, opts)
    key("n", "<leader>6", function() harpoon:list():select(6) end, opts)
    key("n", "<leader>7", function() harpoon:list():select(7) end, opts)
    key("n", "<leader>8", function() harpoon:list():select(8) end, opts)
    key("n", "<leader>9", function() harpoon:list():select(9) end, opts)

    -- Previous / Next
    key("n", "<C-S-p>", function() harpoon:list():prev() end, opts)
    key("n", "<C-S-n>", function() harpoon:list():next() end, opts)
  end,
}
