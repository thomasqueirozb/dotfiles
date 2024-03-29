--don't use swap file
vim.o.swapfile = false
vim.o.autoread = true

-- Triger `autoread` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
vim.cmd[[
augroup load_changed_file
    autocmd!
    " autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ \'\v(c|r.?|!|t)\' && getcmdwintype() == \'\' | checktime | endif
    autocmd FocusGained,BufEnter * if mode() !=? 'c' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END
]]
