vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "nvim-lua/plenary.nvim"
  -- use "nvim-tree/nvim-tree.lua"
  -- use "nvim-tree/nvim-web-devicons" 
  use {
	  'nvim-telescope/telescope.nvim', version = '*',
	  dependencies = {
		  'nvim-lua/plenary.nvim',
		  -- optional but recommended
		  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	  }
  }
  -- use "rebelot/kanagawa.nvim"
  use { "ellisonleao/gruvbox.nvim" }
  use {
	  'nvim-treesitter/nvim-treesitter',
	  lazy = false,
	  build = ':TSUpdate'
  }
end)
