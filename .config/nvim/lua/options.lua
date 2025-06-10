--add recursive search to path
vim.o.path = '.,**,,'

--use clipboard as plus and star registers
vim.o.clipboard = 'unnamed,unnamedplus'

-- buffer on bottom and top when scrolling
vim.o.scrolloff = 4

-- clean up window separator
vim.cmd('highlight WinSeparator guibg=None')

--wildcard ignore case
vim.o.wic = true

-- global status line
vim.o.laststatus = 3

-- -- make harpoon useless
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    callback = function()
        vim.fn.setpos(".", vim.fn.getpos("'\""))
    end,
})

-- Show tabs/trailing spaces
vim.opt.list = true
if vim.fn.has('multi_byte') == 1 and os.getenv('TERM') ~= 'linux' then
    vim.opt.listchars = "tab:»»,trail:•"
    vim.opt.fillchars = "vert:┃"
    vim.opt.showbreak = "↪"
else
    vim.opt.listchars = "tab:>>,trail:~"
end

--     except in go files
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = { '*.go' },
    callback = function()
        vim.o.expandtab = false -- Tab key inserts spaces not tabs
        vim.opt.listchars = "tab:  ,trail:•"
    end,
})

-- Use 2 spaces instead of 4 for these files
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = { '*.nix' },
    callback = function()
        vim.o.tabstop = 2
        vim.o.softtabstop = 2
        vim.o.shiftwidth = 2
    end,
})


-- set leader
vim.g.mapleader = " "

vim.o.confirm = true       -- Ask confirmation like save before quit.
-- set shortmess+=aAcIws    " Hide or shorten certain messages
vim.o.undofile = true      -- Persistent undo
vim.o.linebreak = true     -- Long line wrapping
vim.o.breakindent = true   -- Indent is the same for wrapped line
-- Tabs
vim.o.expandtab = true     -- Tab key inserts spaces not tabs
vim.o.tabstop = 4          -- Width used for tabs
vim.o.softtabstop = 4      -- spaces to enter for each tab
vim.o.shiftwidth = 4       -- amount of spaces for indentation

vim.o.mouse = 'a'          -- Enable mouse

-- Folds: (:h fold-commands)
--   za, zA = toggle,     toggle local
--   zo, zc = open,       close
--   zO, zC = open local, close local
--   zR, zM = open all,   close all
--
--   Global foldlevel
--   zr, zm = +1, -1
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 1
