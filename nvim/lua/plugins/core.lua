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

  {
    "ibhagwan/fzf-lua",
    enabled = false, -- replace by snacks.picker
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
        "debugpy",
        "dockerfile-language-server",
        "gci",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "golangci-lint-langserver",
        "gomodifytags",
        "gopls",
        "hadolint",
        "helm-ls",
        "jsonnet-language-server",
        "lua-language-server",
        "marksman",
        "puppet-editor-services",
        "ruff",
        "shellcheck",
        "shfmt",
        "staticcheck",
        "stylua",
        "terraform-ls",
        "tflint",
        "vale-ls",
        "yaml-language-server",
        "yamlfmt",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
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
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      latex = { enabled = false },
      code = { style = "normal", border = "thick" },
      win_options = {
        conceallevel = { default = 0, rendered = 0 },
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { example = "compact_files" },
      dim = { enabled = true },
      explorer = {
        enabled = true,
        replace_netrw = true, -- Replace netrw with the snacks explorer
      },
      git = { enabled = true },
      indent = {
        enabled = true,
        chunk = {
          enabled = true,
          only_current = true,
        },
      },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        matcher = {
          frecency = true, -- frecency bonus
          history_bonus = true, -- give more weight to chronological order
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}
