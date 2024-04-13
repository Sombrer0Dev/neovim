local M = {
  'hedyhli/outline.nvim',
  cmd = { 'Outline', 'OutlineOpen' },
  opts = {
    symbol_folding = {
      -- Depth past which nodes will be folded by default
      autofold_depth = 1,
    },
  },
  keys = {
    { '<leader>co', '<cmd>Outline<cr>', desc = 'Code Outline' },
  },
}

return M
