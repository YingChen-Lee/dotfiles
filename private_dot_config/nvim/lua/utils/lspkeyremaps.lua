local M = {}
local map = vim.keymap.set
local function opts(desc)
  return { buffer = bufnr, desc = desc }
end

M.keymaps = function()
  -- LSP related
  map("n", "gr", "<cmd> Telescope lsp_references theme=ivy <cr>", opts "Go to references")
  map("n", "gd", "<cmd> Telescope lsp_definitions theme=ivy <cr>", opts "Go to definition")
  map("n", "gI", "<cmd> Telescope lsp_implementations theme=ivy <cr>", opts "Go to implementation")
  map("n", "gD", function()
    vim.lsp.buf.declaration()
  end, opts "Go to declaration")
  -- map("n", "<leader>lf", function()
  --   vim.lsp.buf.format { async = true }
  -- end, opts "LSP Format")
  map("n", "<leader>lr", function()
    require "nvchad.lsp.renamer"()
  end, opts "LSP Rename")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, opts "Toggle Inlay Hint")
end

return M
