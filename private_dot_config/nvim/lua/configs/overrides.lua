local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "bash",
    "c",
    "cpp",
    "rust",
    "go",
    "dockerfile",
    "devicetree",
    "markdown",
    "regex",
    "python",
    "markdown_inline",
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<TAB>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
    },
    is_supported = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == "c" then
        return false
      end
      return true
    end,
  },
  -- textsubjects = {
  --   enable = true,
  --   prev_selection = "<S-tab>",
  --   keymaps = {
  --     ["<cr>"] = "textsubjects-smart",
  --     [";"] = "textsubjects-container-outer",
  --     ["i;"] = "textsubjects-container-inner",
  --   },
  -- },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>ca"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>cA"] = "@parameter.inner",
      },
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
    "luacheck",

    -- web dev stuff
    -- "css-lsp",
    -- "html-lsp",
    -- "typescript-language-server",
    -- "deno",
    "prettier",
    "yaml-language-server",
    "yamllint",

    -- c/cpp stuff
    "cpplint",
    "clangd",
    "clang-format",
    "codelldb",

    -- rust
    "rust-analyzer",

    -- go
    -- "delve",
    -- "gopls",
    -- "golangci-lint",

    -- markdown
    "markdownlint",

    -- bash
    "shfmt",
  },
}

M.telescope = {
  defaults = {
    winblend = 8,
    selection_caret = " ",
    path_display = { "smart" },
  },

  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type",
        "file",
        "--type",
        "symlink",
        -- "--hidden",
        -- "--no-ignore",
        -- ".git",
      },
    },
  },
  extensions = {
    undo = {
      vim_diff_opts = { ctxlen = 2 },
      mappings = {
        i = {
          ["<C-y>"] = function(bufnr)
            return require("telescope-undo.actions").yank_additions(bufnr)
          end,
          ["<S-y>"] = function(bufnr)
            return require("telescope-undo.actions").yank_deletions(bufnr)
          end,
          ["<cr>"] = function(bufnr)
            return require("telescope-undo.actions").restore(bufnr)
          end,
        },
      },
    },
    -- no other extensions here, they can have their own spec too
  },
  extensions_list = { "themes", "terms", "fzf", "luasnip", "undo" },
}

M.trouble = {
  focus = true,
  modes = {
    diagnostics_cascade = {
      mode = "diagnostics", -- inherit from diagnostics mode
      filter = function(items)
        local severity = vim.diagnostic.severity.HINT
        for _, item in ipairs(items) do
          severity = math.min(severity, item.severity)
        end
        return vim.tbl_filter(function(item)
          return item.severity == severity
        end, items)
      end,
    },
    symbols = {
      win = {
        size = 0.4,
      },
    },
    lsp = {
      win = {
        size = 0.3,
      },
    },
  },
}

M.noice = {
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
    },
  },
  routes = {
    {
      filter = { event = "msg_show", kind = "", find = "written" },
      opts = { skip = true },
    },
    {
      view = "split",
      filter = { event = "msg_show", min_height = 20 },
    },
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
  },
  lsp = {
    hover = {
      enabled = false,
    },
    signature = {
      enabled = false,
    },
    override = {
      -- override the default lsp markdown formatter with Noice
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      -- override the lsp markdown formatter with Noice
      ["vim.lsp.util.stylize_markdown"] = true,
      -- override cmp documentation with Noice (needs the other options to work)
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    long_message_to_split = true, -- long messages will be sent to a split
  },
}

M.which_key = {
  ------- TTTIIIMMM, remove this so that we can see the cheetsheet
  -- plugins = {
  --   presets = {
  --     operators = false, -- adds help for operators like d, y, ...
  --     motions = false, -- adds help for motions
  --     text_objects = false, -- help for text objects triggered after entering an operator
  --     windows = false, -- default bindings on <c-w>
  --     nav = false, -- misc bindings to work with windows
  --     z = true, -- bindings for folds, spelling and others prefixed with z
  --     g = false, -- bindings for prefixed with g
  --   },
  -- },
  spec = {
    { "<leader>c", group = "Context" },
    { "<leader>d", group = "Dap" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "Lsp" },
    { "<leader>n", group = "NvChad" },
    { "<leader>r", group = "Rename" },
    { "<leader>s", group = "Search" },
    { "<leader>t", group = "Trouble" },
    { "<leader>w", group = "Whichkey" },
  },
  icons = {
    rules = false,
  },
  ------- TTTIIIMMM, remove this so that we can see the cheetsheet
  -- triggers = { "<leader>" },
}

local HEIGHT_RATIO = 0.6 -- You can change this
local WIDTH_RATIO = 0.6 -- You can change this too
-- git support in nvimtree
M.nvimtree = {
  disable_netrw = true,
  hijack_netrw = true,
  prefer_startup_root = true,
  hijack_cursor = true,
  view = {
    relativenumber = true,
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
    },
  },

  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    indent_width = 2,
    icons = {
      show = {
        git = true,
      },
    },
  },

  update_focused_file = {
    update_root = true,
  },
}

local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 70
local MIN_LABEL_WIDTH = 35
local cmp = require "cmp"
M.cmp = {
  completion = {
    keyword_length = 2,
  },
  formatting = {
    format = function(_, item)
      local cmp_ui = require("nvconfig").ui.cmp
      local icons = require "nvchad.icons.lspkind"
      local icon = (cmp_ui.icons and icons[item.kind]) or ""

      local label = item.abbr
      local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
      if truncated_label ~= label then
        item.abbr = truncated_label .. ELLIPSIS_CHAR
      elseif string.len(label) < MIN_LABEL_WIDTH then
        local padding = string.rep(" ", MIN_LABEL_WIDTH - string.len(label))
        item.abbr = label .. padding
      end
      icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
      item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")

      return item
    end,
  },
  mapping = {
    ["<C-y>"] = cmp.mapping.complete(),
    ["<UP>"] = cmp.mapping.select_prev_item(),
    ["<DOWN>"] = cmp.mapping.select_next_item(),
  },
  sources = {
    { name = "nvim_lsp", priority = 60 },
    { name = "nvim_lua", priority = 50 },
    { name = "luasnip", priority = 40 },
    { name = "cmp_tabnine", priority = 30 },
    { name = "buffer", priority = 20 },
    { name = "path", priority = 10 },
  },
}

M.conform = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    go = { "goimports", "gofmt" },
    rust = { "rustfmt" },
    python = { "black" },
    toml = { "taplo" },
    sh = { "shfmt" },

    -- css = { "prettier" },
    -- html = { "prettier" },
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
}

return M
