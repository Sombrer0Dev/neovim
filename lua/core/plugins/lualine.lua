local M = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    {
      'meuter/lualine-so-fancy.nvim',
      -- lazy = true,
    },
  },
  opts = {
    options = {
      component_separators = { left = '│', right = '│' },
    },
    extensions = vim.g.config.plugins.lualine.extensions,
    sections = {
      lualine_a = { { 'fancy_mode' } },
      lualine_b = { { 'fancy_branch' }, { 'fancy_diff' }, { 'fancy_diagnostics' } },
      lualine_c = {
        { 'fancy_cwd' },
        -- {
        --   function()
        --     return ' zina '
        --   end,
        -- },
      },
      lualine_x = { { 'grapple' }, { 'fancy_macro' } },
      lualine_y = { { 'fancy_progress' }, { 'fancy_location' } },
      lualine_z = { { 'fancy_lsp_servers' } },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
  end,
}
return M
