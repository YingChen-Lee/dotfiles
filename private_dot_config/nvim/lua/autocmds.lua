-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Troubel quickfix
vim.api.nvim_create_autocmd("BufRead", {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd([[cclose]])
        vim.cmd([[Trouble qflist open]])
      end)
    end
  end,
})

--  Markdown, commit  spells checks
local spell_check_filetypes = { "markdown", "gitcommit" }
local augroup = vim.api.nvim_create_augroup("SpellCheckEnable", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(spell_check_filetypes, vim.bo.filetype) then
      -- Spell check
      vim.cmd [[ setlocal spell spelllang=en_us ]]
    end
  end,
  desc = "Disable spell check",
})

local eighty_columns_filetypes = {
  "cpp",
  "c",
  "markdown",
}
local augroup_colorcolumns = vim.api.nvim_create_augroup("SetColorColumn", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = augroup_colorcolumns,
  callback = function(_)
    if vim.tbl_contains(eighty_columns_filetypes, vim.bo.filetype) then
      vim.cmd [[ set colorcolumn=80 ]]
    end
  end,
  desc = "Set SetColorColumn according to file",
})

-- Focus nvim ignored files
local ignore_filetypes = {
  "NvimTree",
  "undotree",
  "diff",
  "toggleterm",
  "dapui_scopes",
  "dapui_breakpoints",
  "dapui_stacks",
  "dapui_watchtes",
  "dapui_console",
  "dap-repl",
  "trouble",
}
local ignore_buftypes = { "nowrite", "nofile", "prompt", "popup", "terminal", "quickfix" }
local augroup_focus = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  group = augroup_focus,
  callback = function(_)
    if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
    end
  end,
  desc = "Disable focus autoresize for BufType",
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup_focus,
  callback = function(_)
    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
    end
  end,
  desc = "Disable focus autoresize for FileType",
})
