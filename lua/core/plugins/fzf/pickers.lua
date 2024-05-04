local M = {}

-- use in some pickers for split search
-- local default_cmd = "belowright new | wincmd J | resize 20"
-- winopts = {
--   split = default_cmd,

---@param opts {cwd?:string} | table
function M.files(opts)
  opts = opts or {}

  local fzflua = require 'fzf-lua'
  local utils = require 'utils.functions'

  if not opts.cwd then
    opts.cwd = utils.safe_cwd(vim.t.Cwd)
  end
  local cmd = nil
  if vim.fn.executable 'fd' == 1 then
    local fzfutils = require 'fzf-lua.utils'
    -- fzf-lua.defaults#defaults.files.fd_opts
    cmd = string.format([[fd --color=never --type f --hidden --follow --exclude .git -x printf "{}: {/} %s\n"]], fzfutils.ansi_codes.grey '{//}')
    opts.fzf_opts = {
      -- process ansi colors
      ['--ansi'] = '',
      ['--with-nth'] = '2..',
      ['--delimiter'] = '\\s',
      ['--tiebreak'] = 'begin,index',
    }
    -- opts._fmt = opts._fmt or {}
    -- opts._fmt.from = function(entry, _opts)
    --   local s = fzfutils.strsplit(entry, ' ')
    --   return s[3]
    -- end
  end
  opts.cmd = cmd

  opts.winopts = {
    fullscreen = false,
    height = 0.60,
    width = 0.40,
    preview = {
      hidden = 'hidden',
    },
  }
  opts.ignore_current_file = true

  return fzflua.files(opts)
end

function M.command_history()
  local fzflua = require 'fzf-lua'

  fzflua.command_history {
    winopts = {
      fullscreen = false,
      height = 0.40,
      width = 0.40,
      preview = {
        hidden = 'hidden',
      },
    },
  }
end

function M.git_branches()
  local fzflua = require 'fzf-lua'
  local utils = require 'utils.functions'
  local winopts = {
    fullscreen = false,
    width = 0.6,
    height = 0.4,
  }

  fzflua.fzf_exec({
    'Local branches',
    'Remote branches',
    'All branches',
  }, {
    actions = {
      ['default'] = function(selected)
        if not selected or #selected <= 0 then
          return
        end
        if selected[1] == 'Local branches' then
          fzflua.git_branches {
            winopts = winopts,
            cwd = vim.t.Cwd or utils.safe_cwd(),
            cmd = 'git branch --color',
            prompt = 'Local❯ ',
          }
        elseif selected[1] == 'Remote branches' then
          fzflua.git_branches {
            winopts = winopts,
            cwd = utils.safe_cwd(vim.t.Cwd),
            cmd = 'git branch --remotes --color',
            prompt = 'Remote❯ ',
          }
        elseif selected[1] == 'All branches' then
          fzflua.git_branches {
            winopts = winopts,
            cwd = utils.safe_cwd(vim.t.Cwd),
            cmd = 'git branch --all --color',
            prompt = 'All❯ ',
          }
        end
      end,
    },
    winopts = {
      fullscreen = false,
      width = 0.1,
      height = 0.1,
      relative = 'cursor',
      row = 1,
      col = 0,
    },
  })
end

---@param no_buffers? boolean
function M.buffers_or_recent(no_buffers)
  local fzflua = require 'fzf-lua'
  local fzfutils = require 'core.plugins.fzf.utils'
  local bufopts = {
    filename_first = true,
    sort_lastused = true,
    winopts = {
      height = 0.3,
      width = 0.3,
      fullscreen = false,
      preview = {
        hidden = 'hidden',
      },
    },
  }
  local oldfiles_opts = {
    prompt = ' Recent: ',
    cwd_only = true,
    include_current_session = true,
    winopts = {
      height = 0.3,
      width = 0.3,
      fullscreen = false,
      preview = {
        hidden = 'hidden',
      },
    },
    keymap = {
      -- fzf = {
      --   ['tab'] = 'down',
      --   ['btab'] = 'up',
      --   ['ctrl-j'] = 'toggle+down',
      --   ['ctrl-i'] = 'down',
      -- },
    },
  }
  local buffers_actions = {}

  local oldfiles_actions = {
    actions = {
      ['ctrl-e'] = function()
        return fzflua.buffers(vim.tbl_extend('force', {
          query = fzfutils.get_last_query(),
        }, bufopts, buffers_actions))
      end,
      ['ctrl-f'] = function()
        local query = fzfutils.get_last_query()
        if query == '' or not query then
          vim.notify 'please provide query before switch to find files mode.'
          return
        end

        M.files {
          cwd = oldfiles_opts.cwd,
          query = query,
        }
      end,
    },
  }
  buffers_actions = {
    actions = {
      ['ctrl-e'] = function()
        fzflua.oldfiles(vim.tbl_extend('force', {
          query = fzfutils.get_last_query(),
        }, oldfiles_opts, oldfiles_actions))
      end,
    },
  }

  local count = #vim.fn.getbufinfo { buflisted = 1 }
  if no_buffers or count <= 1 then
    --- open recent.
    fzflua.oldfiles(vim.tbl_extend('force', {}, oldfiles_opts, oldfiles_actions))
    return
  end
  local _bo = vim.tbl_extend('force', {}, bufopts, buffers_actions)
  return require('fzf-lua').buffers(_bo)
end

--- @param _opts table
local function callgrep(_opts, callfn)
  local utils = require 'utils.functions'
  local fzfutils = require 'core.plugins.fzf.utils'
  local opts = vim.tbl_deep_extend('force', {}, _opts)

  opts.cwd_header = true

  if not opts.cwd then
    opts.cwd = vim.t.Cwd or utils.safe_cwd()
  end

  opts.no_header = false
  opts.winopts = {
    fullscreen = false,
    height = 0.90,
    width = 1,
  }
  opts.rg_opts = opts.rg_opts or [[--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e]]

  opts.actions = vim.tbl_extend('keep', {
    -- press ctrl-e in fzf picker to switch to rgflow.
    ['ctrl-e'] = function()
      -- bring up rgflow ui to change rg args.
      require('rgflow').open(fzfutils.get_last_query(), opts.rg_opts, opts.cwd, {
        custom_start = function(pattern, flags, path)
          opts.cwd = path
          opts.rg_opts = flags
          opts.query = pattern
          return callfn(opts)
        end,
      })
    end,
    ['ctrl-h'] = function()
      --- toggle hidden files search.
      opts.rg_opts = fzfutils.toggle_cmd_option(opts.rg_opts, '--hidden')
      return callfn(opts)
    end,
    ['ctrl-a'] = function()
      --- toggle rg_glob
      opts.rg_glob = not opts.rg_glob
      if opts.rg_glob then
        opts.prompt = opts.prompt .. '(G): '
      else
        -- remove (G): from prompt
        opts.prompt = string.gsub(opts.prompt, '%(G%): ', '')
      end
      -- usage: {search_query} --{glob pattern}
      -- hello --*.md *.js
      return callfn(opts)
    end,
  }, opts.actions)

  return callfn(opts)
end

function M.grep(opts, is_live)
  local fzfutils = require 'core.plugins.fzf.utils'
  opts = opts or {}
  if is_live == nil then
    is_live = true
  end
  local fzflua = require 'fzf-lua'
  if is_live then
    opts.prompt = '󱙓  Live Grep❯ '
    -- fixed strings search
    opts.rg_opts = '--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --fixed-strings'
    local copyopts = vim.deepcopy(opts)

    opts.actions = {
      ['ctrl-k'] = function()
        local new_opts = vim.deepcopy(copyopts)
        new_opts.rg_opts = fzfutils.toggle_cmd_option(opts.rg_opts, '--fixed-strings')
        new_opts.rg_opts = fzfutils.toggle_cmd_option(new_opts.rg_opts, '-e', true)
        new_opts.query = fzfutils.get_last_query()
        vim.print(new_opts.rg_opts)
        fzflua.live_grep(new_opts)
      end,
    }
  else
    opts.input_prompt = '󱙓  Grep❯ '
  end
  return callgrep(
    opts,
    -- schedule: fix fzf picker show and dismiss issue.
    vim.schedule_wrap(function(opts_local)
      if is_live then
        return fzflua.live_grep(opts_local)
      else
        return fzflua.grep(opts_local)
      end
    end)
  )
end

function M.grep_visual(opts)
  local fzflua = require 'fzf-lua'
  return callgrep(opts, function(opts_local)
    return fzflua.grep_visual(opts_local)
  end)
end

return M
