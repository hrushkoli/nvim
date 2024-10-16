dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local lspconfig = require('lspconfig')
local servers = {'ts_ls','pyright','dockerls','arduino_language_server','lua_ls' ,'kotlin_language_server', 'marksman','html','clangd','emmet_ls','jsonls','cssls','sqlls','vimls','yamlls','jdtls','rescriptls','psalm','gradle_ls'}
--


lspconfig.pyright.setup({
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = function(filename)
          return util.root_pattern(unpack(root_files))(filename) or util.path.dirname(filename)
        end,
    settings = {
      python = {
        pythonPath="C:/Program Files/WindowsApps/PythonSoftwareFoundation.Python.3.12_3.12.2032.0_x64__qbz5n2kfra8p0/python3.12.exe",
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true
        }
      }
    }
})

-- Lspconfig
--

-- Use an on_attach function to only map the following keys after
-- the language server attaches to the current buffer
local on_attach  = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- Disable Autoformat
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
end

for _,lsp in ipairs(servers) do
	lspconfig[lsp].setup{
	on_attach = on_attach
}
end
vim.diagnostic.config({
  virtual_text = true
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- M = {}
-- local utils = require "core.utils"
--
-- -- export on_attach & capabilities for custom lspconfigs
--
-- M.on_attach = function(client, bufnr)
--   utils.load_mappings("lspconfig", { buffer = bufnr })
--
--   if client.server_capabilities.signatureHelpProvider then
--     require("nvchad_ui.signature").setup(client)
--   end
--
--   if not utils.load_config().ui.lsp_semantic_tokens then
--     client.server_capabilities.semanticTokensProvider = nil
--   end
-- end
--
-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- M.capabilities.textDocument.completion.completionItem = {
--   documentationFormat = { "markdown", "plaintext" },
--   snippetSupport = true,
--   preselectSupport = true,
--   insertReplaceSupport = true,
--   labelDetailsSupport = true,
--   deprecatedSupport = true,
--   commitCharactersSupport = true,
--   tagSupport = { valueSet = { 1 } },
--   resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits",
--     },
--   },
-- }
--
-- require("lspconfig").lua_ls.setup {
--   on_attach = M.on_attach,
--   capabilities = M.capabilities,
--
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = {
--           [vim.fn.expand "$VIMRUNTIME/lua"] = true,
--           [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
--           [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
--           [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
--         },
--         maxPreload = 100000,
--         preloadFileSize = 10000,
--       },
--     },
--   },
-- }
--
-- return M
