local M = {
  'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
  config = function()
    local leap = require 'leap'
    leap.create_default_mappings()
  end,
}

vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

return M
