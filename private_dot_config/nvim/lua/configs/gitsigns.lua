local options = {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "󰍵" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function opts(desc)
      return { buffer = bufnr, desc = desc }
    end

    local map = vim.keymap.set

    map("n", "gl", function()
      gs.blame_line()
    end, { desc = "Git blame line" })
    map("n", "<leader>gj", function()
      gs.next_hunk()
    end, { desc = "Next hunk" })
    map("n", "<leader>gk", function()
      gs.next_hunk()
    end, { desc = "Previous hunk" })
    map("n", "<leader>gR", function()
      gs.reset_buffer()
    end, { desc = "Reset buffer" })
  end,
}

return options
