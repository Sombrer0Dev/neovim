local M = {
  'folke/trouble.nvim',
  branch = 'dev', -- IMPORTANT!
  keys = {
    {
      '<leader>tt',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>tT',
      '<cmd>Trouble<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      'gR',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<[t>',
      function()
        if require('trouble').is_open() then
          require('trouble').prev { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.WARN)
          end
        end
      end,
      desc = 'Previous Trouble/Quickfix Item',
    },
    {
      '<]t>',
      function()
        if require('trouble').is_open() then
          require('trouble').next { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.WARN)
          end
        end
      end,
      desc = 'Next Trouble/Quickfix Item',
    },
  },
  opts = {
    modes = {
      test = {
        mode = 'diagnostics',
        preview = {
          type = 'split',
          relative = 'win',
          position = 'right',
          size = 0.3,
        },
      },
    },
  }, -- for default options, refer to the configuration section for custom setup.
}

return M
