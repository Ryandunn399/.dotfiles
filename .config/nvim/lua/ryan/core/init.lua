
vim.cmd([[set shiftwidth=4]])
vim.cmd([[set expandtab]]) 
vim.cmd([[set relativenumber]]) 


-- Color Options
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa-wave")


-- Auto Close Plugin
require("autoclose").setup()

-- LSP Stuff

local lsp_zero = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
    },
})

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = true}),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})

require('neogen').setup {
    enabled = true,
    languages = {
        lua = {
            template = {
                annotation_convention = "ldoc",
            },
        },

        python = {
            template = {
                annotation_convention = "google_docstrings",
            },
        },

        rust = {
            template = {
                annotation_convention = "rustdoc",
            },
        },
        
        javascript = {
            template = {
                annotation_convention = "jsdoc",
            },
        },

        typescript = {
            template = {
                annotation_convention = "tsdoc",
            },
        },

        typescriptreact = {
            template = {
                annotation_convention = "tsdoc",
            },
        },
    }
}
