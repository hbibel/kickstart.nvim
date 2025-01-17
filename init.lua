--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('custom.plugins')
require('custom.vimconfigs')

local scala = require('custom.scala')
local keymaps = require('custom.keymaps')
keymaps.basic()

require('custom.commands').basic()

local lsp = require('custom.lsp')
lsp.setup()
-- Scala (Metals) does some extra stuff to normal LSPs
scala.init(lsp.on_attach)

vim.cmd.colorscheme "catppuccin"
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
