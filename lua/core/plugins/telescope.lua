local conf = vim.g.config.plugins
local M = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'ptethng/telescope-makefile',
    { 'nvim-telescope/telescope-fzf-native.nvim', enabled = conf.telescope.fzf_native.enable, build = 'make' },
  },
  keys = {
    -- Local Search
    { '<leader><space>', '<cmd>Telescope buffers layout_strategy=bottom_pane height=0.3<cr>', desc = 'Buffers' },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find {
          layout_strategy = 'bottom_pane',
          layout_config = { height = 0.3 },
          border = false,
        }
      end,
      desc = 'Search in buffer',
    },
    -- Search stuff
    { '<leader>sc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
    { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = 'Strings' },
    { '<leader>s?', '<cmd>Telescope help_tags<cr>', desc = 'Help' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
    { '<leader>sO', '<cmd>Telescope vim_options<cr>', desc = 'Vim Options' },
    { '<leader>sR', '<cmd>Telescope registers<cr>', desc = 'Registers' },
    { '<leader>ss', '<cmd>Telescope grep_string<cr>', desc = 'Word under cursor' },
    { '<leader>s:', '<cmd>Telescope search_history<cr>', desc = 'Search History' },
    { '<leader>s;', '<cmd>Telescope command_history<cr>', desc = 'Command history' },
    {
      '<leader>sf',
      "<cmd>lua require'telescope.builtin'.grep_string{ shorten_path = true, word_match = '-w', only_sort_text = true, search = '' }<cr>",
      desc = 'Word search',
    },
    -- Git
    { '<leader>gG', '<cmd>Telescope git_branches<cr>', desc = 'Branches' },
    { '<leader>gg', '<cmd>Telescope git_status<cr>', desc = 'Status' },
    { '<leader>gm', '<cmd>Telescope git_commits<cr>', desc = 'Commits' },
    -- files
    { '<leader>fF', '<cmd>' .. require('utils.functions').project_files() .. '<cr>', desc = 'Find files (ignore git)' },
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files ' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
    -- misc
    { '<leader>mt', '<cmd>Telescope<cr>', desc = 'Telescope' },
  },
  config = function()
    local telescope = require 'telescope'
    local telescopeConfig = require 'telescope.config'
    local actions = require 'telescope.actions'
    local action_layout = require 'telescope.actions.layout'
    local icons = require 'utils.icons'
    local trouble = require 'trouble.sources.telescope'

    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
    if conf.telescope.grep_hidden then
      table.insert(vimgrep_arguments, '--hidden')
    end
    -- trim the indentation at the beginning of presented line
    table.insert(vimgrep_arguments, '--trim')

    telescope.setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {},
        },
      },
      pickers = {
        find_files = {
          hidden = false,
          title = 'Find Files',
        },
        oldfiles = {
          cwd_only = true,
        },
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
        },
        current_buffer_fuzzy_find = {
          previewer = false,
          results_height = 15,
          winblend = 10,
          layout_strategy = 'horizontal',
        },
        live_grep = {
          only_sort_text = true, -- grep for content and not file name/path
          mappings = {
            i = { ['<c-f>'] = require('telescope.actions').to_fuzzy_refine },
          },
        },
      },
      defaults = {
        file_ignore_patterns = conf.telescope.file_ignore_patterns,
        vimgrep_arguments = vimgrep_arguments,
        mappings = {
          i = {
            -- Close on first esc instead of going to normal mode
            -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
            ['<esc>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<PageUp>'] = actions.results_scrolling_up,
            ['<PageDown>'] = actions.results_scrolling_down,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-q>'] = actions.send_selected_to_qflist,
            ['<C-l>'] = actions.send_to_qflist,
            ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
            ['<c-a>'] = actions.select_all,
            ['<cr>'] = actions.select_default,
            ['<c-v>'] = actions.select_vertical,
            ['<c-h>'] = actions.select_horizontal,
            ['<c-p>'] = action_layout.toggle_preview,
            ['<c-o>'] = action_layout.toggle_mirror,
            ['<c-?>'] = actions.which_key,
            ['<c-x>'] = actions.delete_buffer,
            ['<c-t>'] = trouble.open,
          },
        },
        -- border = false,
        prompt_prefix = table.concat { icons.arrows.ChevronRight, ' ' },
        selection_caret = icons.arrows.DoubleArrowRight,
        entry_prefix = '  ',
        multi_icon = icons.arrows.Diamond,
        initial_mode = 'insert',
        scroll_strategy = 'cycle',
        selection_strategy = 'reset',
        sorting_strategy = 'descending',
        layout_strategy = 'horizontal',
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        -- border = {},
      },
    }

    if conf.noice.enable then
      telescope.load_extension 'noice'
    end
    if conf.telescope.fzf_native.enable then
      telescope.load_extension 'fzf'
    end
  end,
}

return M
