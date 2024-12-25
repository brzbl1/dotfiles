return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    cmd = 'Snacks',
    opts = {
      -- bigfile = { enabled = true },
      notifier = { enabled = true, timeout = 2000, refresh = 100 },
      -- quickfile = { enabled = true },
      -- statuscolumn = { enabled = true, refresh = 500 },
      indent = { enabled = true },
      input = { enabled = true },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 250 },
          easing = 'linear',
        },
      },
      words = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = 'header' },
          -- { title = 'Sessions', icon = '💾' },
          {
            desc = 'Continue',
            icon = '',
            action = ':LoadSession',
            key = 'c',
          },
          {
            desc = 'Sessions',
            icon = '',
            action = ':SesSelecter',
            key = 's',
            padding = 1,
          },

          { icon = '', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          -- { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          {
            icon = '',
            key = 'f',
            desc = 'Find File',
            action = ':Telescope find_files find_command=fd,-tf,-H',
          },

          -- { icon = '󰈢', title = 'Recent Files', section = 'recent_files', indent = 2 },
          {
            desc = 'Recent Files',
            icon = '󰈢',
            action = ':Telescope oldfiles',
            key = 'r',
            padding = 1,
          },

          { desc = 'Lazy', icon = '󰒲', action = ':Lazy', key = 'l' },
          { desc = 'Update', icon = '󰚰', action = ':Lazy sync', key = 'u', padding = 1 },
          { desc = 'CheckHealth', icon = '', action = ':checkhealth', key = 'H' },
          { desc = 'Proto type', icon = '󰙨', action = ':P', key = 'p' },
          {
            icon = '',
            key = 'C',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          -- {
          --   desc = 'Config',
          --   icon = '',
          --   action = ':Telescope find_files find_command=fd,-tf,\\.lua,./.config/nvim',
          --   key = 'C',
          -- },
          { desc = 'Quit', icon = '󰩈', action = ':q', key = 'q', padding = 1 },
          { section = 'startup' },
        },
      },

    },
    keys = {
      {
        '<leader>.',
        ':lua Snacks.scratch()<cr>',
        desc = 'Toggle Scratch Buffer',
      },
      { '<leader>S', ':lua Snacks.scratch.select()<cr>', desc = 'Select Scratch Buffer' },
      { '<leader>n', ':lua Snacks.notifier.show_history()<cr>', desc = 'Notification History' },
      { '<leader>bd', ':lua Snacks.bufdelete()<cr>', desc = 'Delete Buffer' },
      { '<c-/>', ':lua Snacks.terminal()<cr>', desc = 'Toggle Terminal' },
      { '<c-_>', ':lua Snacks.terminal()<cr>', desc = 'which_key_ignore' },
      {
        ']]',
        ':lua Snacks.words.jump(vim.v.count1)<cr>',
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        ':lua Snacks.words.jump(-vim.v.count1)<cr>',
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
      {
        '<leader>z',
        function()
          Snacks.zen()
        end,
        desc = 'Toggle Zen Mode',
      },
      {
        '<leader>Z',
        function()
          Snacks.zen.zoom()
        end,
        desc = 'Toggle Zoom',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle
            .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.inlay_hints():map '<leader>uh'
        end,
      })
    end,
  },

  -- {
  --   'echasnovski/mini.starter',
  --   version = false,
  --   config = function()
  --     local starter = require 'mini.starter'
  --     starter.setup {
  --       items = {
  --         { name = 'Continue', action = 'LoadSession', section = 'Sessions' },
  --         { name = 'Sessions', action = 'SesSelecter', section = 'Sessions' },
  --         { name = 'Old files', action = [[Telescope oldfiles]], section = 'Sessions' },
  --         starter.sections.builtin_actions(),
  --         { name = 'Lazy', action = 'Lazy', section = 'Lazy' },
  --         { name = 'Update', action = 'Lazy sync', section = 'Lazy' },
  --         { name = 'Health', action = 'checkhealth', section = 'CheckHealth' },
  --       },
  --       content_hooks = {
  --         starter.gen_hook.adding_bullet('░ ', true),
  --         starter.gen_hook.aligning('center', 'center'),
  --       },
  --     }
  --   end,
  -- },
}
