local M = {
  'mrjones2014/legendary.nvim',
  -- since legendary.nvim handles all your keymaps/commands,
  -- its recommended to load legendary.nvim before other plugins
  priority = 10000,
  lazy = false,
  -- sqlite is only needed if you want to use frecency sorting
  -- dependencies = { 'kkharji/sqlite.lua' }
  opts = {
    commands = require('core.plugins.legendary.commands').default_commands(),
    keymaps = require('core.plugins.legendary.keymaps').default_keymaps(),
    col_separator_char = '',
    extensions = {
      diffview = true,
      lazy_nvim = true,
      which_key = {
        -- Automatically add which-key tables to legendary
        -- see WHICH_KEY.md for more details
        auto_register = true,
        -- you can put which-key.nvim tables here,
        -- or alternatively have them auto-register,
        -- see WHICH_KEY.md
        opts = {},
        -- controls whether legendary.nvim actually binds they keymaps,
        -- or if you want to let which-key.nvim handle the bindings.
        -- if not passed, true by default
        do_binding = false,
        -- controls whether to use legendary.nvim item groups
        -- matching your which-key.nvim groups; if false, all keymaps
        -- are added at toplevel instead of in a group.
        use_groups = true,
      },
      smart_splits = {
        directions = { 'h', 'j', 'k', 'l' },
        mods = {
          -- for moving cursor between windows
          move = '<M>',
          -- for resizing windows
          resize = '<M-S>',
          -- for swapping window buffers
          swap = false, -- false disables creating a binding
        },
      },
    },
  },
}

vim.keymap.set('n', '<leader>o', '<Cmd>Legendary<CR>', { desc = 'Open Legendary' })

return M
