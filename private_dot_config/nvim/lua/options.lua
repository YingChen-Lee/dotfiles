require "nvchad.options"

local g = vim.g
local opt = vim.opt

-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Enable provider
-- local enable_providers = {
--   "python3_provider",
-- }
-- for _, plugin in pairs(enable_providers) do
--   vim.g["loaded_" .. plugin] = nil
--   vim.cmd("runtime " .. plugin)
-- end
-- local python3_host_prog = "/usr/bin/python3"
-- if vim.uv.os_uname().sysname == "Darwin" then
--   python3_host_prog = "/opt/homebrew/bin/python3"
-- end
-- g.python3_host_prog = python3_host_prog

-- Enabled OSC52 if on ssh
local tty = vim.iter(vim.api.nvim_list_uis()):any(function(ui)
  return ui.chan == 1 and ui.stdout_tty
end)

if tty and os.getenv "SSH_TTY" then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy "+",
      ["*"] = require("vim.ui.clipboard.osc52").copy "*",
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste "+",
      ["*"] = require("vim.ui.clipboard.osc52").paste "*",
    },
  }
end

opt.foldenable = false
opt.clipboard = "unnamedplus"
-- no swap files
opt.swapfile = false
opt.backup = false
-- no line warpping
opt.wrap = false
-- autoread reload changed file
opt.autoread = true
-- -- Set highlight on search
opt.hlsearch = false
opt.incsearch = true
-- Enable break indent
opt.breakindent = true
-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true
-- Decrease update time
opt.updatetime = 250
-- minimun scroll of screen
opt.scrolloff = 8
-- tab set up
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
-- menu and floating window blend
opt.pumblend = 8
opt.winblend = 8
opt.pumheight = 15
opt.colorcolumn = "100"
opt.cmdwinheight = 15

opt.isfname:append "@-@"

-- Set to true if you use nerfont
g.have_nerd_font = true

-- undo hostory directoy
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.undofile = true

-- Catppuccin colorscheme
local base16 = require("base46").get_theme_tb "base_16"
local colors = require("base46").get_theme_tb "base_30"
g.terminal_color_0 = "#6c7086"
g.terminal_color_8 = "#7f849c"
g.terminal_color_0 = base16.base04
g.terminal_color_8 = colors.grey
g.terminal_color_1 = colors.red
g.terminal_color_9 = colors.red
g.terminal_color_2 = colors.green
g.terminal_color_10 = colors.green
g.terminal_color_3 = colors.yellow
g.terminal_color_11 = colors.yellow
g.terminal_color_4 = colors.blue
g.terminal_color_12 = colors.blue
g.terminal_color_5 = colors.pink
g.terminal_color_13 = colors.pink
g.terminal_color_6 = colors.teal
g.terminal_color_14 = colors.teal
g.terminal_color_7 = colors.lavender
g.terminal_color_15 = colors.lavender

--- Setup neovide
if g.neovide then
  opt.pumblend = 25
  opt.winblend = 25

  if vim.uv.os_uname().sysname == "Darwin" then
    opt.guifont = "Fantasquesansm Nerd Font:h21:w1"
    g.neovide_input_macos_option_key_is_meta = "only_left"
    g.neovide_underline_stroke_scale = 1.1
    -- This is a custom config that is not on upstream yet
    g.neovide_underline_offset = 5
  elseif vim.uv.os_uname().sysname == "Linux" then
    opt.guifont = "Fantasquesansm Nerd Font:h15"
    g.neovide_transparency = 0.85
    -- This is a custom config that is not on upstream yet
    g.neovide_underline_offset = 3
  end

  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_vfx_mode = "torpedo"
  g.neovide_scroll_animation_length = 0.2
  -- g.neovide_cursor_vfx_particle_density = 20
  -- g.neovide_cursor_vfx_particle_lifetime = 2
end
