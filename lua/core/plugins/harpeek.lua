---@param path string
---@return string?
local function split_oil_dir(path)
  if path:sub(1, 6) ~= 'oil://' then
    return nil
  end

  if path:sub(-1, -1) == '/' then
    return path:sub(7, -2)
  else
    return path:sub(7, -1)
  end
end

return {
  'WolfeCub/harpeek.nvim',
  -- dir = '~/Workspace/personal/lua/harpeek.nvim/',
  config = function()
    local harpeek = require 'harpeek'
    harpeek.setup {
      format = function(path, index)
        local oil_path = split_oil_dir(path)
        local suffix = ''
        if oil_path then
          path = oil_path
          suffix = '/'
        end

        -- TODO: This logic is pretty opaque. I could probably do something nicer.
        local formatted_line = ''
        formatted_line = vim.fn.fnamemodify(path, ':t') .. suffix
        if index == 1 then
          index = '{n}'
        elseif index == 2 then
          index = '{t}'
        elseif index == 3 then
          index = '{l}'
        elseif index == 4 then
          index = '{p}'
        else
          index = '[' .. index .. ']'
        end
        return index .. ' ' .. formatted_line
      end,
      winopts = {
        row = vim.api.nvim_win_get_height(0) - 10,
      },
    }
    harpeek.open()

    require('legendary').keymaps {
      {
        '<leader>h',
        function()
          harpeek.toggle {
            winopts = {
              row = vim.api.nvim_win_get_height(0) - 10,
            },
          }
        end,
        description = 'Harpeek',
      },
    }
  end,
}
