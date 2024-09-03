local overrides = require "configs.overrides"

return {
  -- Disabled plugin
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Enabled plugin
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = overrides.conform,
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvimtools/none-ls.nvim",
      dependencies = {
        "gbprod/none-ls-luacheck.nvim",
        "nvimtools/none-ls-extras.nvim",
      },
      config = function()
        require "configs.none-ls"
      end, -- Override to setup mason-lspconfig
    },

    config = function()
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "mrcjkb/rustaceanvim",
    -- lazy = false,
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = require("utils.lspkeyremaps").keymaps(),
        },
      }
    end,
    version = "^4", -- Recommended
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        dependencies = {
          "Joakker/lua-json5",
          build = "./install.sh",
        },
        config = function()
          require "configs.dapconfig"
        end,
      },
      "nvim-neotest/nvim-nio",
      {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
        },
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
    config = function()
      dofile(vim.g.base46_cache .. "dap")
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    -- Treesitter parse for nvim-gn
    -- Do "TSInstall gn" after plugin download
    "willcassella/nvim-gn",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- "rrethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/nvim-treesitter-context",
        cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
        config = function()
          require("treesitter-context").setup {
            max_lines = 1,
            line_numbers = true,
          }
        end,
      },
    },
    opts = overrides.treesitter,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "benfowler/telescope-luasnip.nvim" },
      { "debugloop/telescope-undo.nvim" },
    },
    opts = overrides.telescope,
    keys = {
      { "<leader>sb", "<cmd> Telescope buffers theme=ivy <cr>", desc = "Search buffer" },
      { "<leader>sf", "<cmd> Telescope find_files theme=ivy <cr>", desc = "Search all files" },
      { "<leader>sF", "<cmd> Telescope git_files theme=ivy <cr>", desc = "Search git files" },
      { "<leader>sg", "<cmd> Telescope live_grep theme=ivy <cr>", desc = "Search by grep" },
      { "<leader>sh", "<cmd> Telescope help_tags theme=ivy <cr>", desc = "Search help tags" },
      { "<leader>sl", "<cmd> Telescope luasnip theme=ivy<cr>", desc = "Search snippets" },
      { "<leader>sw", "<cmd> Telescope grep_string theme=ivy <cr>", desc = "Search current word" },
      { "<leader>so", "<cmd> Telescope oldfiles theme=ivy <cr>", desc = "Search recent files" },
      {
        "<leader>s/",
        "<cmd> Telescope current_buffer_fuzzy_find theme=ivy <cr>",
        desc = "Search current buffer string",
      },
      { "<leader>nt", "<cmd> Telescope themes <CR>", "Nvchad themes" },
      { "<leader>gc", "<cmd> Telescope git_commits theme=ivy<CR>", desc = "Git commits" },
      { "<leader>nt", "<cmd> Telescope themes <CR>", desc = "Nvchad themes" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons",
    },
    opts = overrides.which_key,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    dependencies = "HiPhish/rainbow-delimiters.nvim",
    config = function()
      dofile(vim.g.base46_cache .. "blankline")
      require "configs.indent-blankline"
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "User FilePost",
    config = function()
      dofile(vim.g.base46_cache .. "rainbowdelimiters")
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        blacklist = {
          "json",
          "log",
        },
      }
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = overrides.noice,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          dofile(vim.g.base46_cache .. "notify")
          require("notify").setup {
            render = "minimal",
            stages = "fade",
          }
        end,
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      dofile(vim.g.base46_cache .. "todo")
      require("todo-comments").setup {
        highlight = {
          keyword = "bg",
          pattern = [[.*<(KEYWORDS)\s*(.*):]],
        },
        search = {
          pattern = [[\b(KEYWORDS)\s*(.*):]],
        },
      }
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    keys = {
      {
        "<leader>td",
        "<cmd>Trouble diagnostics_cascade toggle<cr>",
        desc = "Diagnostics",
      },
      {
        "<leader>tD",
        "<cmd>Trouble diagnostics_cascade toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "LSP Symbols",
      },
      {
        "<leader>tr",
        "<cmd>Trouble lsp toggle focus=false<cr>",
        desc = "LSP Definitions / References",
      },
      {
        "<leader>q",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = overrides.trouble,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "trouble")
      require("trouble").setup(opts)
    end,
  },

  {
    "smoka7/hop.nvim",
    cmd = { "HopWordCurrentLine", "HopWord" },
    config = function()
      dofile(vim.g.base46_cache .. "hop")
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },

  {
    "mfussenegger/nvim-treehopper",
    dependencies = { "smoka7/hop.nvim" },
    config = function()
      require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("harpoon"):setup {
        settings = {
          save_on_toggle = true,
        },
      }
    end,
    keys = {
      {
        "<C-e>",
        function()
          require("utils.harpoon").toggle_menu()
        end,
        desc = "Harpoon toggle",
      },
      {
        "<C-a>",
        function()
          require("utils.harpoon").add_file()
        end,
        desc = "Harpoon add files",
      },
    },
  },

  {
    "tzachar/cmp-tabnine",
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "npxbr/glow.nvim",
    cmd = "Glow",
    ft = "markdown",
    config = function()
      local bin = os.getenv "HOME" .. "/.local/bin/glow"
      if vim.uv.os_uname().sysname == "Darwin" then
        bin = "/opt/homebrew/bin/glow"
      end
      require("glow").setup {
        glow_path = bin,
        border = "shadow",
        style = "$HOME/.config/glow/mocha.json",
        pager = false,
        width = 120,
        height = 100,
        width_ratio = 0.8,
        height_ratio = 0.8,
      }
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    ft = { "fugitive" },
  },

  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },

  {
    "mawkler/modicator.nvim",
    event = "BufReadPost",
    config = function()
      -- reletive line number
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.cursorline = true
      vim.opt.cursorlineopt = "both" -- to enable cursorline!
      require("modicator").setup()
    end,
  },

  {
    "kitagry/vs-snippets",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local vs_snippets = vim.fn.stdpath "data" .. "/lazy/vs-snippets/snippets"
      require("luasnip.loaders.from_vscode").lazy_load { paths = vs_snippets }
    end,
  },

  {
    "madskjeldgaard/cheeky-snippets.nvim",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cheeky = require "cheeky"
      cheeky.setup {
        langs = {
          all = true,
          lua = true,
          cpp = true,
          asm = true,
          cmake = true,
          markdown = true,
          supercollider = true,
        },
      }
    end,
  },

  {
    "kaplanz/retrail.nvim",
    event = "BufReadPre",
    opts = {
      hlgroup = "ExtraWhitespace",
      filetype = {
        exclude = {
          "diff",
          "git",
          "gitcommit",
          "unite",
          "qf",
          "help",
          "markdown",
          "fugitive",
          "lazygit",
          "toggleterm",
          "terminal",
        },
      },
    }, -- calls `setup` using provided `opts`
  },

  {
    "nvim-focus/focus.nvim",
    event = "VeryLazy",
    ---@diagnostic disable-next-line: assign-type-mismatch
    version = false,
    config = function()
      local map = vim.keymap.set
      require("focus").setup {
        ui = {
          hybridnumber = true,
        },
        autoresize = {
          minwidth = 15,
        },
      }
      map("n", "<C-w>s", "<cmd> FocusSplitDown <cr>", { desc = "Horizontal Split" })
      map("n", "<C-w>v", "<cmd> FocusSplitRight <cr>", { desc = "Vertical Split" })
    end,
  },

  {
    "fei6409/log-highlight.nvim",
    ft = "log",
    config = function()
      require("log-highlight").setup {}
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    event = "LspAttach",
    dependencies = {
      "akinsho/toggleterm.nvim",
    },
    config = function()
      require("actions-preview").setup {
        highlight_command = {
          require("actions-preview.highlight").delta "delta --paging=always",
          -- require("actions-preview.highlight").diff_so_fancy(),
          -- require("actions-preview.highlight").diff_highlight(),
        },
        telescope = require("telescope.themes").get_ivy(),
      }
    end,
    keys = {
      {
        "<leader>la",
        function()
          require("actions-preview").code_actions()
        end,
        mode = { "n", "v" },
        desc = "LSP code action",
      },
    },
  },

  {
    "rmagatti/gx-extended.nvim",
    keys = { { "gx", "gx", desc = "Go to url" } },
    config = function()
      require("gx-extended").setup {
        extensions = {
          { -- match github repos in lazy.nvim plugin specs
            patterns = { "*/plugins/*.lua" },
            name = "neovim plugins",
            match_to_url = function(line_string)
              local line = string.match(line_string, "[\"|'].*/.*[\"|']")
              local repo = vim.split(line, ":")[1]:gsub("[\"|']", "")
              local url = "https://github.com/" .. repo
              return line and repo and url or nil
            end,
          },
        },
        open_fn = require("lazy.util").open,
      }
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = {
      "ToggleTerm",
      "TermExec",
    },
    keys = { { "<C-\\>", mode = { "n", "t" } } },
    config = function()
      require "configs.toggleterm"
    end,
  },

  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      dofile(vim.g.base46_cache .. "navic")
      require("nvim-navic").setup {
        highlight = true,
      }
    end,
  },

  {
    "utilyre/barbecue.nvim",
    event = "LspAttach",
    name = "barbecue",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      local base46 = require "utils.base46"
      require("barbecue").setup {
        theme = {
          normal = { fg = base46.base16.base05 },
          separator = { fg = base46.colors.red },
          basename = { fg = base46.base05, bold = false },
        },
        show_dirname = false,
      }
    end,
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure {
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "NvimTree",
          "mason",
          "lazy",
          "toggleterm",
          "harpoon",
          "telescope",
          "log",
        },
        modes_allowlist = { "n" },
      }
    end,
  },

  {
    "vladdoster/remember.nvim",
    event = "BufReadPre",
    config = function()
      require("remember").setup {
        ignore_buftype = {
          "help",
          "nofile",
          "quickfix",
          "prompt",
        },
        ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "hgcommit",
          "svn",
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
        },
      }
    end,
  },

  {
    "danymat/neogen",
    cmd = { "Neogen" },
    config = true,
    opts = {
      snippet_engine = "luasnip",
    },
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },

  {
    'ThePrimeagen/vim-be-good',
    event = "VeryLazy",
  },
}
