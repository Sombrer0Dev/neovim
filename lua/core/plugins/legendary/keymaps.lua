local M = {}

function M.default_keymaps()
  return {
    { '<ESC>', '<C-\\><C-n>', mode = 't' },

    { '<ESC>', '<cmd>noh<CR>', mode = 'n' },

    -- allow moving the cursor through wrapped lines using j and k,
    { 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true }, mode = { 'n', 'v' } },
    { 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true }, mode = { 'n', 'v' } },

    -- better indenting
    { '<', '<gv', mode = 'v' },
    { '>', '>gv', mode = 'v' },
    { 'J', ":m '>+1<CR>gv=gv", mode = 'v' },
    { 'K', ":m '<-2<CR>gv=gv", mode = 'v' },
    -- paste over currently selected text without yanking it
    { 'p', '"_dp', mode = 'x' },
    { 'P', '"_dP', mode = 'x' },

    -- Diagnostic keymaps
    { '[d', vim.diagnostic.goto_prev, description = 'Go to previous diagnostic message', mode = 'n' },
    { ']d', vim.diagnostic.goto_next, description = 'Go to next diagnostic message', mode = 'n' },
    { '<leader>e', vim.diagnostic.open_float, description = 'Floating diagnostic', mode = 'n' },

    -- LSP hover and fold preview
    {
      'K',
      function()
        vim.lsp.buf.hover()
      end,
      description = 'Hover doc or preview fold',
      mode = 'n',
    },
    {
      '<leader>ci',
      function()
        vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
      end,
      description = 'Toggle Inlay Hints',
      mode = 'n',
    },
  }
end

return M
