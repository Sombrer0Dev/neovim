return {
  'Wansmer/treesj',
  keys = { '<space>mSm', '<space>mSj', '<space>mSs' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    vim.keymap.set('n', '<space>mSs', ':TSJSplit<cr>', { desc = 'Split with treesitter' })
    vim.keymap.set('n', '<space>mSj', ':TSJJoin<cr>', { desc = 'Join with treesitter' })
    vim.keymap.set('n', '<space>mSm', ':TSJToggle<cr>', { desc = 'Split/Join with treesitter' })
    require('treesj').setup({--[[ your config ]]})
  end,
}
