local M = {
  enabled = false,
  'nvim-zh/colorful-winsep.nvim',
  config = function()
    require('colorful-winsep').setup {
      highlight = {
        fg = '#89ddff',
      },
    }
  end,
}
return M
