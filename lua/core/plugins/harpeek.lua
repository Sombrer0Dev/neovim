return {
  'WolfeCub/harpeek.nvim',
  -- dir = '~/Workspace/personal/lua/harpeek.nvim/',
  config = function()
    local harpeek = require 'harpeek'
    harpeek.setup {
      format = 'filename',
    }
    harpeek.open()

    require('legendary').keymaps {
      {
        '<leader>h',
        function()
          harpeek.toggle()
        end,
        description = 'Harpeek',
      },
    }
  end,
}
