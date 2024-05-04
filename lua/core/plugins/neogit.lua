local M = {
  'NeogitOrg/neogit',
  branch = 'nightly',
  cmd = 'Neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    disable_signs = false,
    disable_context_highlighting = false,
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      hunk = { '', '' },
      item = { '>', 'v' },
      section = { '>', 'v' },
    },
    integrations = { fzf_lua = true, diffview = true },
    -- override/add mappings
    mappings = {
      -- modify status buffer mappings
      status = {
        -- Adds a mapping with "B" as key that does the "BranchPopup" command
        -- ["B"] = "BranchPopup",
        -- ["C"] = "CommitPopup",
        -- ["P"] = "PullPopup",
        -- ["S"] = "Stage",
        -- ["D"] = "Discard",
        -- Removes the default mapping of "s"
        -- ["s"] = "",
      },
    },
  },
}

return M
