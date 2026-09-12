vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.expandtab = true -- expand tab input with spaces characters
vim.o.smartindent = true -- syntax aware indentations for newline inserts
vim.o.tabstop = 4 -- num of space characters per tab
vim.o.shiftwidth = 4 -- spaces per indentation level
vim.o.signcolumn = "yes"
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>ge", ":Oil<CR>")

vim.pack.add({
    -- {src= "https://github.com/ellisonleao/gruvbox.nvim"},
    {src="https://github.com/rose-pine/neovim"},
    {src="https://github.com/stevearc/oil.nvim"},
    {src="https://github.com/nvim-mini/mini.pick"},
    {src="https://github.com/neovim/nvim-lspconfig"},
})

require "mini.pick".setup()
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

vim.lsp.enable({"lua_ls", "bashls", "ccls", "powershell_es", "terraformls", "gopls"})
vim.diagnostic.config({
  virtual_text = true
})

vim.cmd("colorscheme rose-pine")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
