-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  CursorLine =                  { bg = "one_bg2" },
  Visual =                      { bg = "grey"  },
  LineNr =                      { fg = "light_grey" },
  PmenuSel =                    { bg = "lavender" },
  LspSignatureActiveParameter = { bg = "lavender" },
  FloatBorder =                 { fg = "lavender" },
  LspReferenceText =            { link = "CursorLine" },
  LspReferenceRead =            { link = "CursorLine" },
  LspReferenceWrite =           { link = "CursorLine" },
  Comment =                     { fg = "light_grey", italic = true },
}

---@type HLTable
M.add = {
  TreesitterContext =       { link = "Normal" },
  TSNodeKey =               { link = "HopNextKey" },
  TelescopeSelectionCaret = { fg = "green", bg = "one_bg" },
  ExtraWhitespace =         { bg = "red" },
  NormalMode =              { fg = "blue"},
  InsertMode =              { fg = "dark_purple" },
  VisualMode =              { fg = "cyan" },
  ReplaceMode =             { fg = "orange" },
  CommandMode =             { fg = "green" },
  LspInlayHint =            { fg = "light_grey"},
}

return M
