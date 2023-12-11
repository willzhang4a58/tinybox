-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "catppuccin/nvim",
  "RRethy/vim-illuminate",
  "lukas-reineke/indent-blankline.nvim",
  {"kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async"}
})

-- lsp
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"lua_ls", "clangd", "pylsp"},
})
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {}
lspconfig.clangd.setup {}
lspconfig.pylsp.setup {}
vim.diagnostic.disable()

-- fold
require('ufo').setup()
vim.o.foldlevel = 99

-- skin
vim.opt.number = true
vim.opt.cursorline = true
vim.cmd.colorscheme "catppuccin-macchiato"
require("ibl").setup()
