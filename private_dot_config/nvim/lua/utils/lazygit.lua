local present, toggleterm = pcall(require, "toggleterm.terminal")

if not present then
  return
end

local M = {}

M.lazygit_toggle = function()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get()
  local Terminal = toggleterm.Terminal
  local lazygit = Terminal:new {
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = screen_w,
      height = screen_h,
    },
    on_open = function(_)
      vim.cmd "startinsert!"
    end,
    on_close = function(_) end,
    count = 99,
  }
  lazygit:toggle()
end

return M
