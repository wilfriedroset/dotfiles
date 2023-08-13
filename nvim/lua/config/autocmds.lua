-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local config_group = create_augroup("ConfigGroup", { clear = true })

-- See:
-- https://github.com/neovim/nvim-lspconfig/issues/2685
-- https://github.com/neovim/neovim/issues/23184
create_autocmd({ "BufRead", "BufNewFile" }, {
  group = config_group,
  pattern = "*.tfvars",
  command = "set filetype=terraform",
})
