local present, telescope = pcall(require, "telescope.config")
local harpoon = require("harpoon")

if not present then
  return
end

local M = {}
-- basic telescope configuration
local conf = telescope.values

M.toggle_telescope = function(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

M.toggle_menu = function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end

M.add_file = function ()
 harpoon:list():add()
end

return M
