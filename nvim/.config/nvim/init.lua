local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

require'packer'.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'RRethy/nvim-base16'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'

    use 'dcampos/nvim-snippy'
    use 'dcampos/cmp-snippy'
    use 'honza/vim-snippets'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    use 'lukas-reineke/indent-blankline.nvim'
    use 'numToStr/Comment.nvim'
    use "AckslD/nvim-neoclip.lua"
    use 'sindrets/diffview.nvim'

    use 'preservim/vimux'
    use 'nvim-lualine/lualine.nvim'
end)

vim.g.termguicolors = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.cursorline = true
vim.cmd "colorscheme base16-chalk"

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
                globals = { 'vim' },
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
lspconfig.hls.setup {}

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
            include_surrounding_whitespace = false,
        },
    },
}

local telescope = require 'telescope'
telescope.setup {}
telescope.load_extension 'neoclip'
require('neoclip').setup {}
require('lualine').setup {
	options = {
		theme = 'base16'
	}
}

local function key(mode, chord, fun)
    vim.keymap.set(mode, chord, fun, { noremap = true, silent = true })
end

local function nkey(chord, fun)
    key('n', chord, fun)
end

local function update()
    vim.cmd('source $MYVIMRC')
    vim.cmd('PackerUpdate')
end

local function list_workspace_folders()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

nkey('<Leader>f', require 'telescope.builtin'.oldfiles)
nkey('<Leader>F', require 'telescope.builtin'.git_files)
nkey('<Leader>b', require 'telescope.builtin'.buffers)
nkey('<Leader>s', require 'telescope.builtin'.search_history)
nkey('<Leader>p', '<Cmd>Telescope neoclip<CR>')

nkey('<Leader>dq', '<Cmd>DiffviewClose<CR>')
nkey('<Leader>dr', '<Cmd>DiffviewRefresh<CR>')
nkey('<Leader>dh', '<Cmd>DiffviewFileHistory<CR>')
nkey('<Leader>do', '<Cmd>DiffviewOpen<CR>')

nkey('<Leader>C', '<Cmd>tabedit $MYVIMRC<CR>')
nkey('<Leader>U', update)

nkey('gs', require 'telescope.builtin'.lsp_document_symbols)
nkey('gD', vim.lsp.buf.declaration)
nkey('gd', vim.lsp.buf.definition)
nkey('gy', vim.lsp.buf.type_definition)
nkey('K', vim.lsp.buf.hover)
nkey('gi', vim.lsp.buf.implementation)
nkey('gr', vim.lsp.buf.references)

nkey('<space>wa', vim.lsp.buf.add_workspace_folder)
nkey('<space>wr', vim.lsp.buf.remove_workspace_folder)
nkey('<space>wl', list_workspace_folders)
nkey('<space>rn', vim.lsp.buf.rename)
nkey('<space>ca', vim.lsp.buf.code_action)
nkey('<space>f', vim.lsp.buf.formatting)
nkey('<space>e', vim.diagnostic.open_float)
nkey('[d', vim.diagnostic.goto_prev)
nkey(']d', vim.diagnostic.goto_next)
nkey('<space>q', vim.diagnostic.setloclist)
