local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

local packer = require('packer')
packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'RRethy/nvim-base16'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    --use 'hrsh7th/cmp-buffer'
    --use 'hrsh7th/cmp-path'
    --use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'

    use 'dcampos/nvim-snippy'
    use 'dcampos/cmp-snippy'
    use 'honza/vim-snippets'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use 'nvim-telescope/telescope.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'folke/trouble.nvim'

    use 'rcarriga/nvim-notify'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'numToStr/Comment.nvim'
end)

vim.g.termguicolors = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.expandtab = true
vim.cmd "colorscheme base16-chalk"

vim.notify = require("notify")
require("indent_blankline").setup {}
require('Comment').setup {
    mappings = {
        basic = true,
        extra = true,
        extended = true,
    },
}

local cmp = require 'cmp'
local snippy = require 'snippy'
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local trouble = require 'trouble'

local lspconfig = require 'lspconfig'
cmp.setup({
    snippet = {
        expand = function(args)
            snippy.expand_snippet(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'snippy' },
        { name = 'nvim_lsp_signature_help' },
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.clangd.setup { capabilities = capabilities }
lspconfig.pylsp.setup { capabilities = capabilities }
lspconfig.sumneko_lua.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
  },
}

snippy.setup({
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
})

require 'nvim-treesitter.configs'.setup {
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

require 'nvim-treesitter.configs'.setup {
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ad"] = "@conditional.outer",
                ["id"] = "@conditional.inner",
                ["am"] = "@comment.outer",
                ["im"] = "@comment.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            },
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = 'V', -- blockwise
                ['@block.outer'] = 'V', -- blockwise
            },
            include_surrounding_whitespace = true,
        },
    },
}

local telescope = require 'telescope'
telescope.setup()
trouble.setup {}
