-- =====================================
-- Markdown Settings
-- =====================================

-- Autocommand group for Markdown-specific settings
vim.cmd([[
    augroup MarkdownSettings
        autocmd!
        autocmd FileType markdown lua SetMarkdownSettings()
    augroup END
]])

-- Function that applies Markdown indentation settings
function SetMarkdownSettings()
    vim.bo.tabstop = 2        -- Tabs count as 2 spaces
    vim.bo.shiftwidth = 2     -- Auto-indent shifts by 2 spaces
    vim.bo.expandtab = true   -- Convert tabs to spaces
end


-- =====================================
-- Automatic Filetype Detection for C/C++ Projects
-- =====================================

-- Function to detect project type by looking for .c or .cpp files
local function detect_project_type()
  local handle = io.popen('git ls-files | grep -E "\\.(c|cpp)$"')
  local result = handle:read("*a")
  handle:close()

  -- Prioritize C++ if any .cpp file exists
  if result:match("%.cpp") then
    vim.bo.filetype = 'cpp'
  elseif result:match("%.c") then
    vim.bo.filetype = 'c'
  end
end

-- Autocommand: run detection when opening C/C++ related files
vim.api.nvim_create_autocmd("BufRead", {
  pattern = {"*.c", "*.cpp", "*.h"},
  callback = detect_project_type,
})

