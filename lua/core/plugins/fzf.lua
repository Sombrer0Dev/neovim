local pickers = require 'core.plugins.fzf.pickers'

local M = {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  keys = {
    { '<leader>ff', pickers.files, desc = 'Fzf files' },
    { '<leader>fc', pickers.command_history, desc = 'Fzf command history' },
    { '<leader>fb', pickers.git_branches, desc = 'Fzf git branches' },
    { '<leader>f<space>', '<cmd>FzfLua resume<cr>', desc = 'Fzf resume search' },

    {
      '<leader>fg',
      function()
        pickers.grep({}, true)
      end,
      desc = 'Fzf live grep',
    },
    { '<leader><space>', pickers.buffers_or_recent, desc = 'Fzf open buffers' },
    { '<leader><space>', pickers.grep_visual, desc = 'Fzf grep on visual selection', mode = 'v' },
  },
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup {
      { 'telescope' },
      fzf_opts = {
        ['--margin'] = '0,0',
        ['--padding'] = '0',
      },
      git = {
        status = {
          winopts = {
            preview = { vertical = 'down:70%', horizontal = 'right:70%' },
          },
        },
        commits = { winopts = { preview = { vertical = 'down:60%' } } },
        bcommits = { winopts = { preview = { vertical = 'down:60%' } } },
        branches = {
          -- cmd_add = { "git", "checkout", "-b" },
          cmd_del = { 'git', 'branch', '--delete', '--force' },
          -- winopts = {
          --   preview = { vertical = 'down:75%', horizontal = 'right:75%' },
          -- },
        },
      },
    }

    require('fzf-lua').register_ui_select(function(_, items)
      local min_h, max_h = 0.15, 0.70
      local h = (#items + 4) / vim.o.lines
      if h < min_h then
        h = min_h
      elseif h > max_h then
        h = max_h
      end
      return { winopts = { height = h, width = 0.60, row = 0.40 } }
    end)
  end,
}

return M
