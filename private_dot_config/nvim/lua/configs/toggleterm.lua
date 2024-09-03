local g = vim.g

require("toggleterm").setup {
  direction = "float",
  open_mapping = "<C-\\>",
  terminal_mappings = true,
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  on_close = function(_) end,
}

