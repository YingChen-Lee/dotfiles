require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del
-- Disabled

-- Defualt Telescope binding
del("n", "<leader>b")
del("n", "<leader>fa")
del("n", "<leader>fb")
del("n", "<leader>ff")
del("n", "<leader>fh")
del("n", "<leader>fm")
del("n", "<leader>fo")
del("n", "<leader>fw")
del("n", "<leader>fz")
del("n", "<leader>ma")
del("n", "<leader>gc")
del("n", "<leader>gt")
del("n", "<leader>ds")
del("n", "<leader>ch")
del("n", "<leader>cm")
del("n", "<leader>pt")
del("n", "<leader>th")

-- Terminal
del("t", "<C-x>")
del("n", "<leader>h")
del("n", "<leader>v")
del("n", "<leader>la")
del("n", "<A-v>")
del("n", "<A-h>")
del("n", "<A-i>")

-- NvimTree
del("n", "<leader>n")
del("n", "<leader>rn")
del("n", "<C-n>") -- We want to use <C-n> or <C-p> to move in insert mode
del("i", "<C-b>")

map("n", "Q", "<Nop>")
-- General
map("n", "<leader>rn", [[:%s/\<lt><C-R><C-W>\>/<C-R><C-W>/gI<Left><Left><Left>]], { desc = "Rename String" })
map("n", "<leader>nc", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })
map("n", "<leader>y", [[^y$]], { desc = "Yank no newline" })

map("i", "<C-a>", "<ESC>^i", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map({ "n", "v" }, "x", [["_x]], { desc = "Delete void register" })
map("x", "p", [["_dP]], { desc = "Paste void register" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Visual move up", silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Visual move down", silent = true })
-- Float diagnostic
map("n", "<leader>f", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Float diagnostic" })

-- Telescope Undo
map("n", "<leader>u", "<cmd> Telescope undo theme=ivy <cr>", { desc = "Telescope undo" })

--Gitsign
map("n", "<leader>gb", "<cmd> Git blame <cr>", { desc = "Git blame" })
map("n", "<leader>gf", "<cmd> Git reformat <cr>", { desc = "Git reformat (Vewd)" })


-- Hop
map("n", "<leader>h", "<cmd> HopWord <cr>", { desc = "Hop Word" })
map({ "n", "o" }, "<C-s>", function()
  require("tsht").nodes()
end, { desc = "TreeHopper Visual Selection" })

-- Lazygit
map("n", "<leader>gg", function()
  require("utils.lazygit").lazygit_toggle()
end, { desc = "Toggle Lazygit" })

map("n", "<leader>lf", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format" })
-- Dap
map("n", "<leader>dr", function()
  require("dap").continue()
  require("dapui").open()
end, { desc = "Start or Continue debugger" })
map("n", "<leader>dt", function()
  require("dapui").close()
  require("dap").terminate()
end, { desc = "Terminate debugger" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Add breakpoint" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "Condition: ")
end, { desc = "Add conditional breakpoint" })
map("n", "<F5>", function()
  require("dap").continue()
  require("dapui").open()
end, { desc = "Start or Continue debugger" })
map("n", "<F6>", function()
  require("dap").step_over()
end, { desc = "Step Over" })
map("n", "<F7>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
map("n", "<F8>", function()
  require("dap").step_out()
end, { desc = "Step Out" })
