return {
  'cbochs/grapple.nvim',
  -- lazy = true,
  config = function()
    local grapple = require 'grapple'
    grapple.setup {
      ---Grapple save location
      ---@type string
      save_path = vim.fs.joinpath(vim.fn.stdpath 'data', 'grapple'),

      ---Show icons next to tags or scopes in Grapple windows
      ---@type boolean
      icons = true,

      ---Default scope to use when managing Grapple tags
      ---@type string
      scope = 'git_branch',

      ---User-defined scopes or overrides
      ---For more information, please see the Scopes section
      ---@type grapple.scope_definition[]
      scopes = {},

      ---User-defined tags title function for Grapple windows
      ---By default, uses the resolved scope's ID
      ---@type fun(scope: grapple.resolved_scope): string?
      tag_title = nil,

      ---User-defined scopes title function for Grapple windows
      ---By default, renders "Grapple Scopes"
      ---@type fun(): string?
      scope_title = nil,

      ---User-defined loaded scopes title function for Grapple windows
      ---By default, renders "Grapple Loaded Scopes"
      ---@type fun(): string?
      loaded_title = nil,

      ---Additional window options for Grapple windows
      ---See :h nvim_open_win
      ---@type grapple.vim.win_opts
      win_opts = {
        relative = 'editor',
        width = 0.5,
        height = 10,
        row = 0.5,
        col = 0.5,
        border = 'single',
        focusable = false,
        style = 'minimal',
        title_pos = 'center',

        -- Custom: "{{ title }}" will use the tag_title or scope_title
        title = '{{ title }}',

        -- Custom: adds padding around window title
        title_padding = ' ',
      },
    }
    require('legendary').setup {
      keymaps = {
        { '<leader>a', '<cmd>Grapple toggle<cr>', description = 'Grapple mark' },
        { '<C-e>', '<cmd>Grapple open_tags<cr>', description = 'Grapple open tags' },
        { '<C-n>', '<cmd>Grapple select index=1<cr>' },
        { '<C-t>', '<cmd>Grapple select index=2<cr>' },
        { '<C-l>', '<cmd>Grapple select index=3<cr>' },
        { '<C-p>', '<cmd>Grapple select index=4<cr>' },
      },
    }
    -- vim.keymap.set('n', '<leader>a', '<cmd>Grapple toggle<cr>', { desc = 'Grapple mark' })
    -- vim.keymap.set('n', '<C-e>', '<cmd>Grapple open_tags<cr>')
    --
    -- vim.keymap.set('n', '<C-n>', '<cmd>Grapple select index=1<cr>')
    -- vim.keymap.set('n', '<C-t>', '<cmd>Grapple select index=2<cr>')
    -- vim.keymap.set('n', '<C-l>', '<cmd>Grapple select index=3<cr>')
    -- vim.keymap.set('n', '<C-p>', '<cmd>Grapple select index=4<cr>')
  end,
}
