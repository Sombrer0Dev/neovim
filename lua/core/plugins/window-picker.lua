local M = {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  version = "2.*",
  config = function()
    require("window-picker").setup({
      hint = "floating-big-letter",
      filter_rules = {
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = {
            "neo-tree",
            "neo-tree-popup",
            "notify",
            "packer",
            "qf",
            "diff",
            "fugitive",
            "fugitiveblame",
          },

          -- if the buffer type is one of following, the window will be ignored
          buftype = { "nofile", "help", "terminal" },
        },
      },
    })
  end,
}

return M
