-- inspired by https://github.com/LunarVim/LunarVim/tree/master
-- but heavily stripped down
local utils = require 'utils.functions'

local function init()
  -- Merge defaults and user config
  vim.g.config = require 'config.defaults'

  -- configure vim.opt
  for k, v in pairs(vim.g.config.options) do
    vim.opt[k] = v
  end

  -- autocmds
  require 'config.autocmds'
  -- globals
  require 'utils.globals'
  -- lazy.nvim
  require 'config.lazy'
end

vim.filetype.add {
  pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
}

init()
