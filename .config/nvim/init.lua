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
  {"kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async"},
  "lewis6991/gitsigns.nvim",
  "itchyny/lightline.vim",
  "folke/tokyonight.nvim",
  {'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = {'nvim-lua/plenary.nvim'}},
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
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
vim.opt.colorcolumn = "101"
vim.opt.mouse = ""
vim.o.termguicolors = true
vim.cmd.colorscheme "tokyonight"
require("ibl").setup()
require('gitsigns').setup()

-- tab
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- map
--   normal_mode = n
--   insert_mode = i
--   visual_mode = v
--   visual_block_mode = x
--   term_mode = t
--   command_mode = c
local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = ','
keymap("n", "<Leader>te", ":tabedit <c-r>=expand('%:p:h')<cr>/", {noremap = true, silent = false})
keymap("n", "<Leader>;", ":tabp<cr>", {noremap = true, silent = true})
keymap("n", "<Leader>'", ":tabn<cr>", {noremap = true, silent = true})
keymap("n", "<Leader>vs", ":vs <c-r>=expand('%:p:h')<cr>/", {noremap = true, silent = false})

-- telescope
require('telescope').setup {}
require('telescope').load_extension('fzf')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
