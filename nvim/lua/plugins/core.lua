return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      term_colors = true,
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "light",
        percentage = 0.50, -- percentage of the shade to apply to the inactive window
      },
      highlight_overrides = {
        all = function(colors)
          return {
            LineNr = { fg = colors.blue },
          }
        end,
      },
    },
  },
  { "ConradIrwin/vim-bracketed-paste" },
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    config = function()
      require("tmux").setup({
        navigation = {
          enable_default_keybindings = true,
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {
      { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
    },
    config = true,
    opts = {
      autofold_depth = 2,
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "hcl",
        "html",
        "javascript",
        "json",
        "jsonnet",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "promql",
        "puppet",
        "python",
        "query",
        "regex",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  { "nvim-treesitter/nvim-treesitter-context" },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {}
    end,
  },

  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "theHamsta/nvim-dap-virtual-text" },
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "ansible-language-server",
        "ansible-lint",
        "bash-language-server",
        "black",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "flake8",
        "gci",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "golangci-lint-langserver",
        "gomodifytags",
        "gopls",
        "hadolint",
        "helm-ls",
        "impl",
        "json-lsp",
        "jsonnet-language-server",
        "llm-ls",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "puppet-editor-services",
        "pyright",
        "ruff-lsp",
        "shellcheck",
        "shfmt",
        "staticcheck",
        "stylua",
        "terraform-ls",
        "tflint",
        "vale-ls",
        "yaml-language-server",
        "yamlfix",
        "yamlfmt",
        "yamllint",
      },
    },
  },

  -- Disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        trouble = true, -- true: use trouble to open quickfix
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "m4xshen/smartcolumn.nvim",
  },
  {
    "cappyzawa/trim.nvim",
  },
  { "echasnovski/mini.nvim", version = false },
  { "rfratto/vim-river" },
  { "towolf/vim-helm", ft = "helm" }, -- needed for helmls
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = { style = "normal", border = "thick" },
      win_options = {
        conceallevel = { default = 0, rendered = 0 },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      -- scope = {
      --   enabled = true,
      -- },
      indent = {
        chunk = {
          enabled = true,
          only_current = true,
        },
      },
      scroll = { enabled = false },
      dim = { enabled = true },
    },
  },
}
