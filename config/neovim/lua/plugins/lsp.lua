-- lsp.lua
return {

	-- 1. Mason core
	{
		"williamboman/mason.nvim",
		config = true, -- just call setup()
	},

	-- 2. Bridge + auto-enable
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup {
				ensure_installed = { "lua_ls", "rust_analyzer" },

				-- This is the recommended way in 2025/2026
				handlers = {
					-- default handler for all servers
					function(server_name)
						vim.lsp.config(server_name, {
							-- You can leave most things empty → it will use nvim-lspconfig defaults
							-- Only override what you need
						})
						vim.lsp.enable(server_name)
					end,

					-- Special case: lua_ls (most common override)
					["lua_ls"] = function()
						vim.lsp.config("lua_ls", {
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim" } },
									-- workspace = { library = vim.api.nvim_get_runtime_file("", true) }, -- optional but nice
									telemetry = { enable = false },
								},
							},
						})
						vim.lsp.enable("lua_ls")
					end,
				},
			}
		end,
	},

	-- 3. nvim-lspconfig is still needed (provides defaults + server configs)
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },

		config = function()
			-- ── Global defaults ───────────────────────────────────────
			vim.lsp.config("*", {
				on_attach = function(client, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }

					-- Common LSP keymaps (add what you use)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)

					-- Optional: disable formatting if you use null-ls / conform.nvim later
					-- client.server_capabilities.documentFormattingProvider = false
				end,

				capabilities = vim.lsp.protocol.make_client_capabilities(),
			})

			-- Format on save (only for servers that support it)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format { async = false, id = client.id }
							end,
						})
					end
				end,
			})
		end,
	},
}
