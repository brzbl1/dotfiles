return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      version = '*',
      dependencies = { 'giuxtaposition/blink-cmp-copilot' },

      ---@module 'blink.cmp'
      config = function()
        local cmp = require 'blink.cmp'
        cmp.setup {
          enabled = function()
            return vim.bo.ft ~= 'TelescopePrompt'
          end,
          keymap = {
            -- preset = "enter",
            ['<CR>'] = {
              function()
                return vim.fn.getcmdtype() == '' and cmp.select_and_accept() or cmp.accept()
              end,
              'fallback',
            },
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<Tab>'] = {
              function()
                return cmp.snippet_active() and cmp.snippet_forward() or cmp.select_next()
              end,
              'fallback',
            },
            ['<S-Tab>'] = {
              function()
                return cmp.snippet_active() and cmp.snippet_backward() or cmp.select_prev()
              end,
              'fallback',
            },
            ['<C-e>'] = { 'hide' },
            -- ['<C-e>'] = { 'cancel','fallback' },
            ['<C-l>'] = { 'snippet_forward' },
            ['<C-h'] = { 'snippet_backward' },
            -- ['<C-Space>'] = cmp.mapping.complete_common_string(),
          },
          completion = {
            list = { selection = 'manual' },
            -- list = { selection = 'auto_insert' },
            menu = {
              draw = {
                treesitter = { 'lsp' },
                columns = {
                  { 'label',     'label_description', gap = 1 },
                  { 'kind_icon', 'kind' },
                },
              },
              border = 'rounded',
            },
            documentation = {
              window = { border = 'single' },
              auto_show = true,
              auto_show_delay_ms = 200,
            },
            accept = {
              auto_brackets = { enabled = true }, -- 自動括弧サポート
            },
            -- ghost_text = {
            --   enabled = true,
            -- },
          },
          signature = { enabled = true, window = { border = 'single' } },

          appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
          },

          sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
            providers = {
              copilot = {
                name = 'copilot',
                module = 'blink-cmp-copilot',
                score_offset = 100,
                async = true,
                transform_items = function(_, items)
                  local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
                  local kind_idx = #CompletionItemKind + 1
                  CompletionItemKind[kind_idx] = 'Copilot'
                  for _, item in ipairs(items) do
                    item.kind = kind_idx
                  end
                  return items
                end,
              },
              buffer = {
                name = 'Buffer',
                module = 'blink.cmp.sources.buffer',
                opts = {
                  get_bufnrs = function()
                    return { vim.api.nvim_get_current_buf() }
                  end,
                },
              },
            },

            cmdline = function()
              local type = vim.fn.getcmdtype()
              if vim.tbl_contains({ '/', '?' }, type) then
                return { 'buffer' }
              else
                return { 'cmdline' }
              end
              -- return {}
            end,
          },
        }
      end,

      -- opts_extend = { 'sources.default' },
    },

    config = function()
      local lspcfg = require 'lspconfig'
      local lsp_default = lspcfg.util.default_config
      lsp_default.capabilities = require('blink.cmp').get_lsp_capabilities(lsp_default.capabilities)
      -- vim.tbl_deep_extend('force', lsp_default.capabilities, require('blink.cmp').default_capabilities())
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

      local srvs = { 'bashls', 'lua_ls', 'nimls' }
      for _, srv in ipairs(srvs) do
        lspcfg[srv].setup(cfgs)
      end
    end,
  },
}
