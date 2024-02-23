-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "<leader>gD", "<cmd>Lspsaga goto_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "<leader>gt", "<cmd>Lspsaga term_toggle<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>/", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lspconfig["pylsp"].setup({
  -- capabilities = capabilities,
  on_attach = on_attach,
  settings = {
      pylsp = {
          plugins = {
              flake8 = {
                  enabled = false
              },
              autopep8 = {
                  enabled = false
              },
              yapf = {
                  enabled = false
              },
              pyflakes = {
                  enabled = false
              },
              mccabe = {
                  enabled = false
              },
              pycodestyle = {
                  enabled = false
              }
          }
      }
  }
})
