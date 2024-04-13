local conf = vim.g.config
local nvim_lsp = require("lspconfig")
local utils = require("core.plugins.lsp.utils")
local lsp_settings = require("core.plugins.lsp.settings")

local capabilities = vim.lsp.protocol.make_client_capabilities()


local vlsp = vim.lsp
-- enable autocompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- NVIM UFO
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

require("utils.functions").on_attach(function(client, buffer)
  require("core.plugins.lsp.keys").on_attach(client, buffer)
end)

for _, lsp in ipairs(conf.lsp_servers) do
  nvim_lsp[lsp].setup({
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    end,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      json = lsp_settings.json,
      Lua = lsp_settings.lua,
      yaml = lsp_settings.yaml,
      gopls = lsp_settings.gopls,
      jedi_language_server = lsp_settings.jedi,
      sqlls = lsp_settings.sqlls,
    },
  })
end

vlsp.handlers["textDocument/publishDiagnostics"] = vlsp.with(vlsp.diagnostic.on_publish_diagnostics, {
  underline = false,
})

vim.diagnostic.config({
  update_in_insert = true
})
