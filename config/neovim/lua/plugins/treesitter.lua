-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },  -- can be lazy now – we force load below
  init = function()
    -- THIS IS THE MAGIC LINE
    -- Force-load the plugin immediately, before any config runs
    vim.api.nvim_exec_autocmds("User", { pattern = "LazyLoad", modeline = false })
    require("lazy").load({ plugins = { "nvim-treesitter" } })

    -- Tiny delay so runtimepath is definitely ready
    vim.schedule(function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.notify("Treesitter failed to load – will retry on first file open", vim.log.levels.WARN)
        return
      end

      configs.setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "css", "json",
          "bash", "yaml", "toml", "markdown", "markdown_inline",
          "rust", "go", "python", "c", "cpp", "zig",
        },
        auto_install = true,
        sync_install = false,

        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            node_decremental = "<bs>",
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start    = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end      = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
        },

        autotag = { enable = true },
        endwise = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
      })

      -- Folding
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
    end)
  end,

  -- No config key at all – everything happens in init + vim.schedule
  -- Optional extras (they load normally, no more dependency hell)
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
  },
}
