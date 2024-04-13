local nightfox = require 'nightfox'
nightfox.setup {
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath 'cache' .. '/nightfox',
    compile_file_suffix = '_compiled', -- Compiled file suffix
    transparent = false, -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false, -- Non focused panes set to alternative background
    module_default = true, -- Default enable value for modules
    colorblind = {
      enable = false, -- Enable colorblind support
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0, -- Severity [0,1] for protan (red)
        deutan = 0, -- Severity [0,1] for deutan (green)
        tritan = 0, -- Severity [0,1] for tritan (blue)
      },
    },
    styles = { -- Style to be applied to different syntax groups
      comments = 'NONE', -- Value is any valid attr-list value `:help attr-list`
      conditionals = 'NONE',
      constants = 'NONE',
      functions = 'NONE',
      keywords = 'NONE',
      numbers = 'NONE',
      operators = 'NONE',
      strings = 'NONE',
      types = 'NONE',
      variables = 'NONE',
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = { -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {
    all = {
      TelescopeNormal = { bg = 'palette.bg2', fg = 'palette.fg2' },
      TelescopeBorder = { bg = 'palette.bg2', fg = 'palette.bg2' },
      TelescopePromptNormal = { bg = 'palette.bg4' },
      TelescopePromptBorder = { bg = 'palette.bg4', fg = 'palette.bg4' },
      TelescopePromptTitle = { bg = 'palette.bg4', fg = 'palette.bg4' },
      TelescopePreviewTitle = { bg = 'palette.bg2', fg = 'palette.bg2' },
      TelescopeResultsTitle = { bg = 'palette.bg2', fg = 'palette.bg2' },
    },
  },
}
vim.cmd('colorscheme ' .. vim.g.config.theme.nightfox.variant)
