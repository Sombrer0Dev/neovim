local dc = vim.deepcopy
local M = {}

local center_list = require('telescope.themes').get_ivy {
  results_height = 10,
}

M.find_buffers = function()
  local opts = dc(center_list)
  require('telescope.builtin').current_buffer_fuzzy_find(opts)
end

return M
