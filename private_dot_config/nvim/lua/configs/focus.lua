local map = vim.keymap.set

require("focus").setup {
  ui = {
    hybridnumber = true,
  },
  autoresize = {
    minwidth = 15,
  },
}

map('n', '<C-w>s', '<cmd> FocusSplitDown <cr>', {desc = "Horizontal Split" })
map('n', '<C-w>v', '<cmd> FocusSplitRight <cr>', {desc = "Vertical Split" })
