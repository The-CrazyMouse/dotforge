-- ~/.config/nvim/lua/plugins/cmp.lua
return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},

		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },

				mapping = cmp.mapping.preset.insert({
					["<C-n>"]     = cmp.mapping.scroll_docs(-4),
					["<C-p>"]     = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"]      = cmp.mapping.confirm({ select = false }),
					["<Tab>"]     = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"]   = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip",  priority = 800 },
					{ name = "buffer",   priority = 500 },
					{ name = "path",     priority = 250 },
				}),

				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},

				-- CLEAN, THIN, NO-SHADOW BORDER + SOLID BACKGROUND
				window = {
					completion = cmp.config.window.bordered({
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- thin rounded
						winhighlight = "Normal:NormalFloat,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						winhighlight = "Normal:NormalFloat,FloatBorder:CmpBorder",
					}),
				},

				experimental = { ghost_text = true },
			})

			-- cmdline setups
			cmp.setup.cmdline({ "/", "?" }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })
			cmp.setup.cmdline(":",
				{
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({ { name = "path" } },
						{ { name = "cmdline" } })
				})

			-- ──────── EVERFOREST + TRANSPARENT FIX (this actually works 100%) ────────
			local bg = "#2d353b"                                 -- Everforest soft float bg
			local border = "#5c6a72"                             -- nice muted gray from Everforest

			vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg })   -- main background
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = border, bg = bg })
			vim.api.nvim_set_hl(0, "CmpBorder", { fg = border, bg = bg }) -- custom group used above
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3a464c" }) -- selected item highlight
			-- ───────────────────────────────────────────────────────────────────────
		end,
	},
}
