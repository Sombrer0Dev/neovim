---@diagnostic disable: missing-fields
local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-endwise',
    'mfussenegger/nvim-ts-hint-textobject',
    'windwp/nvim-ts-autotag',
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-context',
  },
  config = function()
    local conf = vim.g.config
    require('nvim-treesitter.configs').setup {
      ensure_installed = conf.treesitter_ensure_installed,
      ignore_install = {}, -- List of parsers to ignore installing
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          scope_incremental = '<CR>',
          node_incremental = '<TAB>',
          node_decremental = '<S-TAB>',
        },
      },
      endwise = {
        enable = true,
      },
      indent = { enable = true },
      autopairs = { enable = true },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = { query = '@function.outer', desc = 'Function Outer' },
            ['if'] = { query = '@function.inner', desc = 'Function Inner' },
            ['ac'] = { query = '@class.outer', desc = 'Class Outer' },
            ['ic'] = { query = '@class.inner', desc = 'Class Inner' },
            ['al'] = { query = '@loop.outer', desc = 'Loop Outer' },
            ['il'] = { query = '@loop.inner', desc = 'Loop Inner' },
            ['ib'] = { query = '@block.inner', desc = 'Block Inner' },
            ['ab'] = { query = '@block.outer', desc = 'Block Outer' },
            ['ir'] = { query = '@parameter.inner', desc = 'Parameter Inner' },
            ['ar'] = { query = '@parameter.outer', desc = 'Parameter Outer' },
            ['ia'] = { query = '@assignment.lhs', desc = 'Assignment Lhs' },
            ['aa'] = { query = '@assignment.rhs', desc = 'Assignment Rhs' },
          },
        },
        move = {
          enable = true,
          set_jumps = true,

          goto_next_start = {
            [']p'] = { query = '@parameter.inner', desc = 'Goto Next Start Parameter Inner' },
            [']m'] = { query = '@function.outer', desc = 'Goto Next Start Function outer' },
            [']]'] = { query = '@class.outer', desc = 'Goto Next Start Class Outer' },
          },

          goto_next_end = {
            [']M'] = { query = '@function.outer', desc = 'Goto Next End Function Outer' },
            [']['] = { query = '@class.outer', desc = 'Goto Next End Class Outer' },
          },

          goto_previous_start = {
            ['[p'] = { query = '@parameter.inner', desc = 'Goto Previous Start Parameter Inner' },
            ['[m'] = { query = '@function.outer', desc = 'Goto Previous Start Function Outer' },
            ['[['] = { query = '@class.outer', desc = 'Goto Previous Start Class Outer' },
          },

          goto_previous_end = {
            ['[M'] = { query = '@function.outer', desc = 'Goto Previous End Function Outer' },
            ['[]'] = { query = '@class.outer', desc = 'Goto Previous End Class Outer' },
          },
        },
      },
    }

    require('nvim-ts-autotag').setup()

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.hypr = {
      install_info = {
        url = 'https://github.com/luckasRanarison/tree-sitter-hypr',
        files = { 'src/parser.c' },
        branch = 'master',
      },
      filetype = 'hypr',
    }
  end,
}

return M
