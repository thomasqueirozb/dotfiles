local gh = function(x) return 'https://github.com/' .. x end

-- PackChanged hooks must be defined before vim.pack.add
-- (nvim may install all packages greedily from lockfile on first launch)
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
            if not ev.data.active then
                vim.cmd.packadd('nvim-treesitter')
            end
            vim.cmd('TSUpdate')
        end
    end,
})

vim.pack.add({
    -- Completion
    gh('hrsh7th/cmp-buffer'),
    gh('hrsh7th/cmp-cmdline'),
    gh('hrsh7th/cmp-nvim-lsp'),
    gh('hrsh7th/cmp-path'),
    gh('hrsh7th/cmp-vsnip'),
    gh('hrsh7th/nvim-cmp'),
    gh('hrsh7th/vim-vsnip'),
    gh('hrsh7th/vim-vsnip-integ'),

    -- Utilities
    gh('jamessan/vim-gnupg'),
    gh('junegunn/fzf'),
    gh('junegunn/fzf.vim'),
    gh('nvim-tree/nvim-web-devicons'),
    gh('nvim-lualine/lualine.nvim'),
    gh('nvim-treesitter/nvim-treesitter'),
    gh('onsails/lspkind.nvim'),

    -- File tree
    gh('nvim-tree/nvim-tree.lua'),

    -- Themes
    gh('folke/tokyonight.nvim'),
    gh('ellisonleao/gruvbox.nvim'),

    -- LSP
    gh('williamboman/mason.nvim'),
    gh('williamboman/mason-lspconfig.nvim'),
    gh('neovim/nvim-lspconfig'),
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    gh('stevearc/conform.nvim'),

    -- Editing
    gh('dk949/file_line.nvim'),
    gh('numToStr/Comment.nvim'),
    gh('akinsho/git-conflict.nvim'),

    -- Telescope
    gh('nvim-lua/plenary.nvim'),
    gh('nvim-telescope/telescope.nvim'),
})

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require('nvim-tree').setup()
require('Comment').setup()
require('file_line').setup({ enable_gf = true })
require('git-conflict').setup()
