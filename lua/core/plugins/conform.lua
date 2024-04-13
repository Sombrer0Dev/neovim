local M = {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>F',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      go = { 'goimports', 'gofumpt' },
      sql = { 'sqlfluff' },
    },
    -- Set up format-on-save
    format_on_save = function(_)
      -- Disable with a global or buffer-local variable
      if vim.g.enable_autoformat then
        return { timeout_ms = 500, lsp_fallback = true }
      end
    end, -- Customize formatters
    formatters = {},
  },
}

vim.api.nvim_create_user_command('FormatDisable', function()
  vim.g.enable_autoformat = false
end, {
  desc = 'Disable autoformat-on-save',
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.g.enable_autoformat = true
end, {
  desc = 'Re-enable autoformat-on-save',
})

local utils = require 'utils.functions'
vim.keymap.set('n', '<leader><C-f>', function()
  if vim.g.enable_autoformat then
    vim.cmd 'FormatDisable'
  else
    vim.cmd 'FormatEnable'
  end
  utils.notify(string.format('Autoformatting %s', vim.g.enable_autoformat and 'on' or 'off'), vim.log.levels.INFO, 'lsp.utils')
end, { desc = 'Toggle autoformat' })

return M
