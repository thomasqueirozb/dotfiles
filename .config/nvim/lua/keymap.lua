-- Change windows with ctrl+(hjkl)
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {})
-- Split the window vertically and horizontally
vim.api.nvim_set_keymap('n', '_', '<C-W>s<C-W><Down>', {})
vim.api.nvim_set_keymap('n', '<Bar>', '<C-W>v<C-W><Right>', {})


-- Re-visual text after changing indent
vim.api.nvim_set_keymap('v', '>', '>gv', {})
vim.api.nvim_set_keymap('v', '<', '<gv', {})

-- Don't copy text when deleting
vim.api.nvim_set_keymap('n', '<leader>x', '"_x', {})
vim.api.nvim_set_keymap('n', '<leader>d', '"_d', {})
vim.api.nvim_set_keymap('v', '<leader>x', '"_x', {})
vim.api.nvim_set_keymap('v', '<leader>d', '"_d', {})


vim.api.nvim_set_keymap('n', '<leader>i', ':tabnew $MYVIMRC<CR>:cd %:h<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>v', ':source $MYVIMRC<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>s', ':source %<CR>', {})

vim.api.nvim_set_keymap('n', '<leader>h', ':noh<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', { silent = true })

vim.api.nvim_set_keymap('n', '<leader>te', ':tabnew<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnext<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':tabfirst<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>tp', ':tabprevious<CR>', { silent = true })

vim.api.nvim_set_keymap('n', '<M-h>', ':tabprevious<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<M-j>', ':tabmove -1<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<M-k>', ':tabmove +1<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<M-l>', ':tabnext<CR>', { silent = true })

--vim.api.nvim_set_keymap('n', '<up>', ':resize +5<CR>', {})
--vim.api.nvim_set_keymap('n', '<down>', ':resize -5<CR>', {})
--vim.api.nvim_set_keymap('n', '<left>', ':vertical resize -5<CR>', {})
--vim.api.nvim_set_keymap('n', '<right>', ':vertical resize +5<CR>', {})

--Escape leaves input mode in neovim-terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<c-\\><C-n>', {})

--Fin with f
vim.api.nvim_set_keymap('n', '<leader>f', ':find ', {})
--Edit with e
vim.api.nvim_set_keymap('n', '<leader>e', ':edit ', {})


-- Plugin maps
vim.api.nvim_set_keymap('n', '<leader><space>', ':Files<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>.', ':Files %:h<CR>', {})

-- nnoremap <silent> <Leader>- :tabedit <C-R>=expand("%:p:h")<CR><CR>
vim.api.nvim_set_keymap('n', '<leader>/', ':Rg<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>bb', ':Buffers<CR>', {})


-- Comments
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', {})
vim.api.nvim_set_keymap('v', '<C-_>', 'gcgv', {})
-- For MacOS
vim.api.nvim_set_keymap('n', '<M-_>', 'gcc', {})
vim.api.nvim_set_keymap('v', '<M-_>', 'gcgv', {})

vim.api.nvim_set_keymap('n', '<C-\\>', 'gbc', {})
vim.api.nvim_set_keymap('v', '<C-\\>', 'gbgv', {})


-- Other functions
function Strip_trailing_whitespace()
    local current_pos = vim.fn.getpos('.')
    local current_search = vim.fn.getreg('/')

    vim.cmd([[%s/\s\+$//e]])

    vim.fn.setreg('/', current_search) -- Restore previous search
    vim.fn.setpos('.', current_pos)    -- Restore cursor position
end

vim.cmd([[command! SS lua Strip_trailing_whitespace()]])
vim.cmd([[command! StripTrailingWhitespace lua Strip_trailing_whitespace()]])
vim.api.nvim_set_keymap('n', '<Leader>ss', ':lua Strip_trailing_whitespace()<CR>', { silent = true })
