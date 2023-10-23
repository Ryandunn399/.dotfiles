local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
    print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {"rebelot/kanagawa.nvim"},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'m4xshen/autoclose.nvim'},

    {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
         dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- LSP Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
        }
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {'L3MON4D3/LuaSnip'}
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "go", "rust", "css" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },

    -- Neogen
    { 
        "danymat/neogen", 
        dependencies = "nvim-treesitter/nvim-treesitter", 
        config = true,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*" 
    },       
})
