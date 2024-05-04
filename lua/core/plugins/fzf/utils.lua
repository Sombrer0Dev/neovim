local M = {}

function M.get_last_query()
  local fzflua = require('fzf-lua')
  return vim.trim(fzflua.config.__resume_data.last_query or '')
end

--- @param option_to_toggle string hidden=true or --no-hidden
--- @param insert_at_end? boolean
M.toggle_cmd_option = function(cmd_string_or_table, option_to_toggle, insert_at_end)
  local cmd_is_table = true
  if type(cmd_string_or_table) == 'string' then
    cmd_is_table = false
    -- split string to table by white space
    cmd_string_or_table = vim.split(cmd_string_or_table, '%s+')
  end

  -- if option_to_toggle in table, remove it, or add to it.
  local is_in_table = false
  for i, v in ipairs(cmd_string_or_table) do
    if v == option_to_toggle then
      table.remove(cmd_string_or_table, i)
      is_in_table = true
      break
    end
  end
  if not is_in_table then
    if insert_at_end then
      table.insert(cmd_string_or_table, option_to_toggle)
    else
      -- insert at start
      table.insert(cmd_string_or_table, 2, option_to_toggle)
    end
  end

  if cmd_is_table then
    return cmd_string_or_table
  else
    return table.concat(cmd_string_or_table, ' ')
  end
end

return M
