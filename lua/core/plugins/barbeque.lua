return {
  'utilyre/barbecue.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  name = 'barbecue',
  version = '*',
  dependencies = {
    'SmiteshP/nvim-navic',
  },
  opts = {
    -- configurations go here
  },
}
