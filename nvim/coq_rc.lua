return {
  {
    'neovim/nvim-lspconfig', -- REQUIRED: for native Neovim LSP integration
    lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
    dependencies = {
      -- main one
      { 'ms-jpq/coq_nvim', branch = 'coq' },

      -- -- 9000+ Snippets
      { 'ms-jpq/coq.artifacts',  branch = 'artifacts' },

      -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- Need to **configure separately**
      { 'ms-jpq/coq.thirdparty', branch = '3p' },
      -- - shell repl
      -- - nvim lua api
      -- - scientific calculator
      -- - comment banner
      -- - etc
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = true, -- if you want to start COQ at startup
        -- Your COQ settings here
      }
    end,

    config = function()
      local lsp = require 'lspconfig'
      local coq = require 'coq'
      local lsp_default = lsp.util.default_config
      -- lsp_default.capabilities =
      --   vim.tbl_deep_extend('force', lsp_default.capabilities, require('cmp_nvim_lsp').default_capabilities())

      local cfgs = {
        init_options = {
          documentFormatting = true,
          -- documentRangeFormatting = true,
        },
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
            runtime = {
              version = 'LuaJIT',
            },
            -- diagnostics = { globals = { 'vim', 'vim.fn' } },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
                -- vim.fn.stdpath('data') .. '/lazy/emmylua-nvim',
                -- vim.fn.stdpath('data') .. '/lazy/nvim-treesitter/',
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
        lsp[srv].setup(coq.lsp_ensure_capabilities(cfgs))
      end
      -- Your LSP settings here
    end,
  },
}
