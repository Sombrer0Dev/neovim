return {

  {
    'echasnovski/mini.comment',
    event = { 'BufReadPre', 'BufNewFile' },
    -- is not loaded without explicitly saying it
    config = true,
  },

  {
    'echasnovski/mini.hipatterns',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local hi = require 'mini.hipatterns'
      return {
        highlighters = {
          -- Highlight 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          gogen = { pattern = '%f[%w]()go:generate()%f[%W]', group = 'MiniHipatternsNote' },
          gobuild = { pattern = '%f[%w]()go:build()%f[%W]', group = 'MiniHipatternsNote' },
          hex_color = hi.gen_highlighter.hex_color(),
        },
      }
    end,
  },
}
