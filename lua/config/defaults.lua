local fn = vim.fn

return {
  options = {
    clipboard = 'unnamedplus', -- keep in sync with the system clipboard
    completeopt = 'menuone,noselect', -- A comma separated list of options for Insert mode completion
    conceallevel = 0, -- so that `` is visible in markdown files
    confirm = true, -- confirm to save changes before exiting modified buffer
    cursorline = true, -- highlight the current line
    dir = fn.stdpath 'data' .. '/swp', -- swap file directory
    -- formatoptions = "jcroqlnt",               -- tcqj
    grepprg = 'rg --vimgrep --smart-case --', -- use rg instead of grep
    hidden = true, -- Enable modified buffers in background
    history = 500, -- Use the 'history' option to set the number of lines from command mode that are remembered.
    ignorecase = true, -- ignore case in search patterns
    inccommand = 'nosplit', -- preview incremental substitute
    list = false, -- enable or disable listchars
    listchars = {
      tab = '| ',
      trail = '+',
      extends = '>',
      precedes = '<',
      space = '·',
      nbsp = '␣',
    },
    wrap = false,
    mouse = 'a', -- enable mouse see :h mouse
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    pumblend = 10, -- Popup blend
    pumheight = 10, -- Maximum number of entries in a popup
    scrolloff = 15, -- Minimal number of screen lines to keep above and below the cursor
    shiftround = true, -- Round indent
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    tabstop = 2, -- how many columns a tab counts for
    expandtab = true, -- use spaces instead of tabs
    laststatus = 3, -- 3 for global statusline 2 for per window statusline
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    sidescrolloff = 5, -- The minimal number of columns to scroll horizontally
    signcolumn = 'yes', -- Always show the signcolumn, otherwise it would shift the text each time
    smartcase = true, -- Don't ignore case with capitals
    smartindent = false, -- Insert indents automatically
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = true, -- enable/disable swap file creation
    termguicolors = true, -- set term gui true colors (most terminals support this)
    timeoutlen = 400, -- time to wait for a mapped sequence to complete (in milliseconds)
    ttimeoutlen = 0, -- Time in milliseconds to wait for a key code sequence to complete
    undodir = fn.stdpath 'data' .. '/undodir', -- set undo directory
    undofile = true, -- enable/disable undo file creation
    undolevels = 1000,
    updatetime = 300, -- faster completion
    wildignorecase = true, -- When set case is ignored when completing file names and directories
    wildmode = 'longest:full,full', -- Command-line completion mode
    winminwidth = 5, -- minimum window width
    wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]],
  },

  plugins = {
    git = {
      -- which tool to use for handling git merge conflicts
      -- choose between "git-conflict" and "diffview" or "both"
      merge_conflict_tool = 'diffview',
    },
    indent_blankline = {
      enable_scope = true,
    },
    lazy = {
      dev = {
        path = '$HOME/workspace/github.com/',
      },
      disable_neovim_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
    lualine = {
      -- https://github.com/nvim-lualine/lualine.nvim#extensions
      extensions = { 'lazy', 'fugitive', 'nvim-dap-ui', 'quickfix', 'neo-tree' },
    },
    noice = {
      enable = true, -- Noice heavily changes the Neovim UI ...
    },
    symbol_usage = {
      enable = true,
    },
    telescope = {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      -- requires cmake and gcc toolchain
      fzf_native = {
        enable = true,
      },
      -- which patterns to ignore in file switcher
      file_ignore_patterns = {
        '%.7z',
        '%.avi',
        '%.JPEG',
        '%.JPG',
        '%.V',
        '%.RAF',
        '%.burp',
        '%.bz2',
        '%.cache',
        '%.class',
        '%.dll',
        '%.docx',
        '%.dylib',
        '%.epub',
        '%.exe',
        '%.flac',
        '%.ico',
        '%.ipynb',
        '%.jar',
        '%.jpeg',
        '%.jpg',
        '%.lock',
        '%.mkv',
        '%.mov',
        '%.mp4',
        '%.otf',
        '%.pdb',
        '%.pdf',
        '%.png',
        '%.rar',
        '%.sqlite3',
        '%.svg',
        '%.tar',
        '%.tar.gz',
        '%.ttf',
        '%.webp',
        '%.zip',
        '.git/',
        '.gradle/',
        '.idea/',
        '.settings/',
        '.vale/',
        '.vscode/',
        '__pycache__/*',
        'build/',
        'env/',
        'gradle/',
        'node_modules/',
        'smalljre_*/*',
        'target/',
        'vendor/*',
      },
      -- enable greping in hidden files
      grep_hidden = true,
    },
  },

  theme = {
    -- catppuccin, nightfox, tokyonight, tundra, kanagawa
    name = 'oxocarbon',
    catppuccin = {
      -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      variant = 'catppuccin-mocha',
    },
    kanagawa = {
      -- dragon, lotus, wave, c_dragon (custom dragons)
      variant = 'dragon',
    },
    nightfox = {
      -- nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
      variant = 'carbonfox',
    },
    tokyonight = {
      -- night storm day moon
      variant = 'night',
    },
    oxocarbon = {},
  },
  -- treesitter parsers to be installed
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  treesitter_ensure_installed = {
    'bash',
    'proto',
    'vimdoc',
    'cmake',
    'php',
    'css',
    'dockerfile',
    'go',
    'gomod',
    'gosum',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'query',
    'python',
    'regex',
    'toml',
    'vim',
    'yaml',
    'http',
    'c',
  },

  -- LSPs that should be installed by Mason-lspconfig
  lsp_servers = {
    'bashls',
    'typst_lsp',
    'dockerls',
    'jsonls',
    'bufls',
    'gopls',
    'marksman',
    'jedi_language_server',
    'lua_ls',
    'tailwindcss',
    'tsserver',
    'yamlls',
    'phpactor',
    'sqlls',
    -- 'basedpyright',
  },

  -- Tools that should be installed by Mason
  tools = {
    -- Formatter
    'black',
    'prettier',
    'stylua',
    'shfmt',
    'ruff-lsp',
    -- Linter
    'yamllint',
    -- DAP
    'delve',
    'codelldb',
    'sqlfluff',
  },
}
