return {
  {
    'neovim/nvim-lspconfig', -- REQUIRED: for native Neovim LSP integration
    -- lazy = false,            -- REQUIRED: tell lazy.nvim to start this plugin at startup
    dependencies = {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local lspcfg = require 'lspconfig'
      local lsp_default = lspcfg.util.default_config
      lsp_default.capabilities =
          vim.tbl_deep_extend('force', lsp_default.capabilities, require('cmp_nvim_lsp').default_capabilities())

      local cfgs = {
        init_options = {
          documentFormatting = true,
          -- documentRangeFormatting = true,
        },
        -- on_attach = function(client, buf)
        --   if vim.bo[buf].ft == 'lua' then
        --
        --   end
        -- end,
        settings = {
          html = {
            diagnostics = {
              enable = true,
            },
          },

          css = { validProperties = {} },

          Lua = {
            completion = {
              workspaceWord = true,
              callSnippet = 'Both',
              -- callSnippet = 'blend',
            },
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim', 'vim.fn', 'vim.uv' } },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
                -- vim.fn.stdpath('data') .. '/lazy/emmylua-nvim',
                -- vim.fn.stdpath 'data' .. '/lazy/nvim-treesitter/',
              },
              checkThirdParty = false,
              -- maxPreload = 2000,
              -- preloadFileSize = 1000,
            },
            telemetry = { enable = false },
          },
        },
      }

      -- local srvs = { 'bashls', 'lua_ls', 'pylsp', 'nim_langserver' }
      local srvs = { 'bashls', 'lua_ls', 'nimls' }
      for _, srv in ipairs(srvs) do
        lspcfg[srv].setup(cfgs)
      end

      --- cmp-nvim ---
      local cmp = require 'cmp'

      cmp.setup {
        sources = cmp.config.sources {
          { name = 'nvim_lsp', priority = 6 },
          { name = 'snippy' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'fish' },
          -- { name = 'nvim_lsp_signature_help' }
        },
        confirmation = { completeopt = 'menu,menuone,noinsert' },
        formatting = {
          fields = { 'abbr', 'menu', 'kind' },
          format = function(entry, item)
            local menu_icon = {
              cmdline = '',
              nvim_lsp = '',
              nvim_lua = '',
              path = Symbols[item.kind],
              buffer = Symbols[item.kind],
            }
            item.menu = menu_icon[entry.source.name] or entry.source.name
            -- item.kind = Symbols[item.kind]
            return item
          end,
        },
        snippet = {
          expand = function(args)
            require('snippy').expand_snippet(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ['<Up>'] = cmp.mapping.select_prev_item(),
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete_common_string(),
          ['<C-e>'] = cmp.mapping.close(),
        },
      }

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources {
          { name = 'path' },
          { name = 'cmdline' },
        },
      })
    end,
  },

  --- snippet ---

  {
    'dcampos/nvim-snippy',
    -- dependencies = { 'dcampos/cmp-snippy' },
    opts = {
      mappings = {
        is = {
          ['<Tab>'] = 'expand_or_advance',
          ['<C-l>'] = 'expand_or_advance',
          ['<S-Tab>'] = 'previous',
          ['<C-h'] = 'previous',
        },
        nx = {
          ['<leader>x'] = 'cut_text',
        },
      },
    },
  },
}
