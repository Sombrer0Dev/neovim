local M = {}

M._keys = {
  { '<leader>lD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
  {
    '<leader>lR',
    function()
      require 'inc_rename'
      return ':IncRename ' .. vim.fn.expand '<cword>'
    end,
    expr = true,
    desc = 'Rename',
    has = 'rename',
  },
  { '<leader>lI', '<cmd>LspInfo<cr>', desc = 'Lsp Info' },
  {
    '<leader>ld',
    '<cmd>FzfLua lsp_definitions<cr>',
    desc = 'Goto Definition',
    has = 'definition',
  },
  { '<leader>lr', '<cmd>FzfLua lsp_references<cr>', desc = 'References' },
  {
    '<leader>li',
    '<cmd>FzfLua lsp_implementations<cr>',
    desc = 'Goto Implementation',
  },
  {
    '<leader>lt',
    '<cmd>FzfLua lsp_typedefs<cr>',
    desc = 'Goto Type Definition',
  },
  { '<leader>lS', vim.lsp.buf.signature_help, desc = 'Signature Help', has = 'signatureHelp' },
  -- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
  {
    '<leader>la',
    function()
      require('fzf-lua').lsp_code_actions {
        winopts = {
          relative = 'cursor',
          width = 0.6,
          height = 0.6,
          row = 1,
          preview = { horizontal = 'up:70%' },
        },
        previewer = 'codeaction_native',
        preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
      }
    end,
    desc = 'Code Action',
    mode = { 'n', 'v' },
    has = 'codeAction',
  },
  { '<leader>ls', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Document Symbols' },
  { '<leader>le', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Document Diagnostics' },
  { '<leader>lq', vim.diagnostic.setloclist, desc = 'Diagnostics in qflist' },
}

function M.on_attach(client, buffer)
  local Keys = require 'lazy.core.handler.keys'
  local keymaps = {}
  local wk = require 'which-key'

  wk.register({
    l = {
      w = { 'Workspaces' },
    },
  }, { prefix = '<leader>', mode = 'n' })

  for _, value in ipairs(M._keys) do
    local keys = Keys.parse(value)
    if keys.rhs == vim.NIL or keys.rhs == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. 'Provider'] then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or 'n', keys.lhs, keys.rhs, opts)
    end

    require('legendary').setup { extensions = { which_key = { auto_register = true } } }
  end
end

return M
