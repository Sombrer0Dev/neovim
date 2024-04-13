local get_project_name = function()
  local project_directory, err = vim.loop.cwd()
  if project_directory == nil then
    vim.notify(err, vim.log.levels.WARN)
    return nil
  end

  local project_name = vim.fs.basename(project_directory)
  if project_name == nil then
    vim.notify('Unable to get the project name', vim.log.levels.WARN)
    return nil
  end

  return project_name
end

local M = {
  'backdround/global-note.nvim',
  config = function()
    local global_note = require 'global-note'
    global_note.setup {
      -- Filename to use for default note (preset).
      -- string or fun(): string
      filename = 'global.md',

      -- Directory to keep default note (preset).
      -- string or fun(): string
      directory = vim.fn.stdpath 'data' .. '/global-note/',

      -- Floating window title.
      -- string or fun(): string
      title = 'Global note',

      -- Ex command name.
      -- string
      command_name = 'GlobalNote',

      -- A nvim_open_win config to show float window.
      -- table or fun(): table
      window_config = function()
        local window_height = vim.api.nvim_list_uis()[1].height
        local window_width = vim.api.nvim_list_uis()[1].width
        return {
          relative = 'editor',
          border = 'single',
          title = 'Note',
          title_pos = 'center',
          width = math.floor(0.7 * window_width),
          height = math.floor(0.85 * window_height),
          row = math.floor(0.05 * window_height),
          col = math.floor(0.15 * window_width),
        }
      end,

      -- It's called after the window creation.
      -- fun()
      post_open = function() end,

      -- Whether to use autosave. Autosave saves buffer on closing window
      -- or exiting Neovim.
      -- boolean
      autosave = true,

      -- Additional presets to create other global, project local, file local
      -- and other notes.
      -- { [name]: table } - tables there have the same fields as the current table.
      additional_presets = {
        project_local = {
          command_name = 'ProjectNote',

          filename = function()
            return get_project_name() .. '.md'
          end,

          title = 'Project note',
        },
      },
    }

    require('which-key').register {
      n = {
        function()
          global_note.toggle_note 'project_local'
        end,
        'Toggle project note',
      },
      { prefix = '<leader>' },
    }
  end,
}

return M
