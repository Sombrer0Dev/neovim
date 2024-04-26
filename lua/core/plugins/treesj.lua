return {
  'Wansmer/treesj',
  keys = {
    { '<space>msm', '<cmd>TSJSplit<cr>', desc = 'Split with treesitter' },
    { '<space>msj', '<cmd>TSJJoin<cr>', desc = 'Join with treesitter' },
    { '<space>mss', '<cmd>TSJToggle<cr>', desc = 'Split/Join with treesitter' },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup {--[[ your config ]]
    }
  end,
}
