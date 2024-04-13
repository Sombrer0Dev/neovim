local M = {
  'chrisgrieser/nvim-scissors',
  event = 'InsertEnter',
  config = function(_)
    require('scissors').setup {
      snippetDir = vim.fn.stdpath 'config' .. '/snippets/scissors',
      editSnippetPopup = {
        height = 0.4, -- relative to the window, number between 0 and 1
        width = 0.6,
        border = 'none',
        keymaps = {
          cancel = 'q',
          saveChanges = '<CR>',
          goBackToSearch = '<BS>',
          deleteSnippet = '<C-BS>',
          openInFile = '<C-o>',
          insertNextToken = '<C-t>', -- works in insert & normal mode
        },
      },
      -- `none` writes as a minified json file using `vim.encode.json`.
      -- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
      -- you version control your snippets.
      jsonFormatter = 'jq', -- "yq"|"jq"|"none"
    }
    require('legendary').keymaps {
      {
        '<leader>cse',
        function()
          require('scissors').editSnippet()
        end,
        description = 'Edit existing snippets',
      },
      {
        '<leader>csa',
        function()
          require('scissors').addNewSnippet()
        end,
        description = 'Add snippet',
      },
    }
  end,
}

return M
