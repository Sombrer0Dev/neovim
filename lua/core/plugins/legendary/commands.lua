local M = {}

function M.default_commands()
  return {
    { ':Q', ':q' },
    { ':Qa', ':qa' },
    { ':W', ':w' },
    { ':Wq', ':wq' },
    { ':Wqa', ':wq' },
    { ':Wa', ':wa' },
    {
      ':Comment',
      {
        n = 'gcc',
        v = 'gc',
      },
      description = 'Toggle comment',
    },
  }
end

return M
