return {
  'codethread/qmk.nvim',
  enabled = false,
  cmd = "QMKFormat",
  config = function()
    local conf = {
      name = 'LAYOUT',
      layout = {
        'x x x x x x _ _ _ x x x x x x',
        'x x x x x x _ _ _ x x x x x x',
        'x x x x x x _ _ _ x x x x x x',
        'x x x x x x x _ x x x x x x x',
        '_ _ x x x x^x _ x^x x x x _ _',
      },
    }
    require('qmk').setup(conf)
  end,
}
