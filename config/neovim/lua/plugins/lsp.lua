return {
  -- Mason: Installs language servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Bridge Mason to LSP (updated for native API)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer" },  -- Auto-install these
        handlers = {
          function(server_name)
            -- Use native vim.lsp.config instead of lspconfig.setup
            vim.lsp.config(server_name, {
              on_attach = function(client, bufnr)
                -- Your keymaps here (global on_attach can be in vim.lsp.config('*'))
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                -- Add more...
              end,
              capabilities = vim.lsp.protocol.make_client_capabilities(),
            })
            vim.lsp.enable(server_name)  -- Activate it
          end,
        },
      })
    end,
  },
  -- LSP Configs (still needed for defaults)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Global defaults (applies to all servers)
      vim.lsp.config("*", {
        on_attach = function(client, bufnr)
          -- Shared keymaps and logic here
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          -- ... (rest of your keymaps)
        end,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      -- Example: Customize Lua LSP (extends nvim-lspconfig's default)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
          },
        },
      })
      vim.lsp.enable("lua_ls")  -- Enable it (Mason will handle others via handlers)

      -- Format on save (via autocmd, as before)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function() vim.lsp.buf.format({ async = false }) end,
            })
          end
        end,
      })
    end,
  },
}
