-- Keybinding --
--
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Python
local home = os.getenv('HOME')
vim.env.PYENV_VERSION = vim.fn.system('pyenv version'):match('(%S+)%s+%(.-%)')
vim.g.python3_host_prog = home .. "/.pyenv/versions/3.12.5/envs/nvim/bin/python"

init_selection = "<leader>si" -- set to `false` to disable one of the mappings
node_incremental = "<leader>si"
scope_incremental = "<leader>sc"
node_decremental = "<leader>so"


-- Vim Options -- 

vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false -- line wrapping

vim.opt.tabstop = 4 -- spaces
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- tabs to spaces

vim.opt.clipboard = "unnamedplus" -- sync with system clipboard

vim.opt.scrolloff = 999 -- keep cursor at center

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true -- when using vim commands

vim.opt.termguicolors = true -- terminal gui colors

-- Lua 5.1 rocks
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"
