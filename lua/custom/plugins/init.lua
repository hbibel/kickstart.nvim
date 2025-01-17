local scala = require('custom.scala')
local go = require('custom.go')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',
			{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
			'folke/neodev.nvim',
		},
	},

	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'rafamadriz/friendly-snippets',
		},
		config = function()
			require("custom.plugins.cmp").setup()
		end,
	},

	{ 'folke/which-key.nvim', opts = {} },

	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},

	{ "catppuccin/nvim",      name = "catppuccin", priority = 1000 },
	{ "rose-pine/neovim",     name = "rose-pine",  priority = 1000 },

	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				icons_enabled = true,
				component_separators = '|',
				section_separators = '',
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff' },
				lualine_c = { 'filename', scala.metals_status },
				lualine_x = { 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
		},
	},

	{
		'lukas-reineke/indent-blankline.nvim',
		opts = {
			char = '┊',
			show_trailing_blankline_indent = false,
		},
	},

	{ 'numToStr/Comment.nvim', opts = {} },

	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
		config = function()
			require("custom.plugins.telescope").setup()
		end
	},

	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
		config = function()
			require('custom.plugins.treesitter').setup()
		end,
	},

	require 'kickstart.plugins.autoformat',

	{ 'mfussenegger/nvim-dap' },
	-- require 'kickstart.plugins.debug',

	{ 'github/copilot.vim' },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	},

	scala.plugins,
	go.plugins,

}, {})
