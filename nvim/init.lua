vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.expandtab = true -- expand tab input with spaces characters
vim.o.smartindent = true -- syntax aware indentations for newline inserts
vim.o.tabstop = 4 -- num of space characters per tab
vim.o.shiftwidth = 4 -- spaces per indentation level
vim.o.signcolumn = "yes"
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>ge', ':Oil<CR>')

vim.pack.add({
    {src= "https://github.com/ellisonleao/gruvbox.nvim"},
    {src="https://github.com/stevearc/oil.nvim"},
    {src="https://github.com/nvim-mini/mini.pick"},
    {src="https://github.com/neovim/nvim-lspconfig"},
})

require "mini.pick".setup()
require "oil".setup()

vim.lsp.enable({"lua_ls", "python", "bash", "c", "powershell"})

vim.cmd("colorscheme gruvbox")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
