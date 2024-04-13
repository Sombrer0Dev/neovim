local utils = require 'utils.functions'
local map = vim.keymap.set

map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Remap for dealing with visual line wraps
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- paste over currently selected text without yanking it
map('v', 'p', '"_dp')
map('v', 'P', '"_dP')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Floating diagnostic' })

-- Quickfix
map('n', '<C-j>', '<cmd>cnext<cr>', { desc = 'Next entry' })
map('n', '<C-k>', '<cmd>cprevious<cr>', { desc = 'Previous entry' })
map('n', '<leader>qq', "<cmd>lua require('utils.functions').toggle_qf()<cr>", { desc = 'Toggle Quickfix' })
map('n', '<leader>qd', vim.diagnostic.setqflist, { desc = 'Open diagnostics list' })
map('n', '<leader>qg', '<cmd>Gitsigns setqflist<cr>', { desc = 'Open git list' })
-- Search for 'FIXME', 'HACK', 'TODO', 'NOTE'
map('n', '<leader>qt', function()
  utils.search_todos()
end, { desc = 'List TODOs' })

-- Buffer Navigation
-- resizing splits
-- map('n', '<M-H>', '<cmd>SmartResizeLeft<cr>', { desc = 'Resize left' }) --'require('smart-splits').resize_left)
-- map('n', '<M-J>', '<cmd>SmartResizeDown<cr>', { desc = 'Resize down' }) --'require('smart-splits').resize_down)
-- map('n', '<M-K>', '<cmd>SmartResizeUp<cr>', { desc = 'Resize up' }) --'require('smart-splits').resize_up)
-- map('n', '<M-L>', '<cmd>SmartResizeRight<cr>', { desc = 'Resize right' }) --'require('smart-splits').resize_right)
-- -- moving between splits
-- map('n', '<M-h>', '<cmd>SmartCursorMoveLeft<cr>', { desc = 'Move left' }) --'('smart-splits').move_cursor_left)
-- map('n', '<M-j>', '<cmd>SmartCursorMoveDown<cr>', { desc = 'Move down' }) --('smart-splits').move_cursor_down)
-- map('n', '<M-k>', '<cmd>SmartCursorMoveUp<cr>', { desc = 'Move up' }) --('smart-splits').move_cursor_up)
-- map('n', '<M-l>', '<cmd>SmartCursorMoveRight<cr>', { desc = 'Move right' }) --'('smart-splits').move_cursor_right)

-- Terminal Management
map('t', '<esc>', '<c-\\><c-n>', { noremap = true })

-- LSP hover and fold preview
map('n', 'K', function()
  vim.lsp.buf.hover()
end, { desc = 'Hover doc or preview fold' })

if vim.lsp.inlay_hint then
  vim.keymap.set('n', '<leader>ci', function()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
  end, { desc = 'Toggle Inlay Hints' })
end
