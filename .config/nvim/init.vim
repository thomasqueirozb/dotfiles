" vim:fileencoding=utf-8:foldmethod=marker

" Fold usage:                More info here: https://vim.fandom.com/wiki/Folding
"   za     = toggle
"   zA     = toggle local
"
"   zo, zc = open,       close
"   zO, zC = open local, close local
"   zR, zM = open all,   close all
"
"   Global foldlevel
"   zr, zm = +1, -1

let g:mapleader = "\<Space>"

" Basic configuration {{{
runtime! archlinux.vim " Arch defaults - /usr/share/vim/vimfiles/archlinux.vim

scriptencoding utf8

" system clipboard (requires +clipboard)
set clipboard^=unnamed,unnamedplus

set nocompatible       " Don't simulate vi
set hlsearch           " highlight search items
set incsearch          " searches are performed as you type
set number             " enable line numbers
set relativenumber     " enable relative line numbers
set confirm            " ask confirmation like save before quit.
set wildmenu           " Tab completion menu when using command mode
set expandtab          " Tab key inserts spaces not tabs
set softtabstop=4      " spaces to enter for each tab
set shiftwidth=4       " amount of spaces for indentation
set shortmess+=aAcIws  " Hide or shorten certain messages
set undofile           " Persistent undo
set hidden             " Change buffer without saving
set linebreak          " Long line wrapping
set breakindent        " Indent is the same for wrapped line

set mouse=a            " enable mouse
syntax enable          " syntax highlighting
set foldmethod=syntax
set foldlevel=1
" }}}

" Plugins {{{
" Plugged {{{
call plug#begin('~/.local/share/nvim/plugged')
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Status line
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'tell-k/vim-autopep8'
Plug 'dense-analysis/ale'
" Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'maksimr/vim-jsbeautify'

" Latex
Plug 'lervag/vimtex' " TODO

" Fugitive - git
Plug 'tpope/vim-fugitive'

" Colorschemes

" " Dracula
" Plug 'dracula/vim', { 'as': 'dracula' }
" " Gruvbox
" Plug 'gruvbox-community/gruvbox'
Plug 'danilo-augusto/vim-afterglow'
call plug#end()
" }}}

" ALE {{{
    "\'c': ['gcc', 'clang'],
let g:ale_linters = {
    \'c': [],
    \'cpp': [],
    \'javascript': [],
    \'typescript': ['eslint', 'tsserver', 'prettier'],
    \'python': ['flake8', 'mypy', 'pylint'],
    \}
"     \'c': ['gcc'],
"     \'cpp': ['g++'],
"     \'javascript': [],
"     \'typescript': ['eslint', 'tsserver', 'prettier'],
"     \'python': ['flake8', 'mypy', 'pylint'],
"     \}

let g:ale_fixers = {
    \'c': ['clang-format'],
    \'cpp': ['clang-format'],
    \'javascript': ['prettier'],
    \'json': ['prettier'],
    \'typescript': ['eslint'],
    \'markdown': ['prettier'],
    \'python': ['black'],
    \}
let g:ale_fix_on_save=1

" Black fixes bad-continuation but pylint still warns.
let g:ale_python_pylint_options='--disable=C0114,C0115,C0116,C0103,bad-continuation --max-line-length=100'
let g:ale_python_black_options='--line-length 100'
" let g:ale_python_autopep8_options='--max-line-length 79' " Does not work

let g:ale_cpp_parse_makefile=1
let g:ale_cpp_gcc_options = '-std=c++20 -Wall'

let g:ale_c_parse_makefile=1

let g:clang_format_options='IndentWidth: 4,
\ AccessModifierOffset: -4,
\ AllowShortIfStatementsOnASingleLine: true,
\ Standard: c++20,
\ ColumnLimit: 100'

if &expandtab == 0
    let g:clang_format_options = g:clang_format_options . ', UseTab: UT_Always'
endif

"join(['a', 'b', 'c']) == 'a' . 'b' . 'c'
let g:ale_c_clangformat_options='--style="{' . g:clang_format_options . '}"'
" }}}
" COC {{{

" :CocInstall coc-marketplace
" To have :CocList marketplace
" Learn more @ github.com/fannheyward/coc-marketplace

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nnoremap <leader>cr :CocRestart<CR>

" }}}
" Airline {{{
set laststatus=2
set noshowmode
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
" }}}
" Fugitive {{{
" Get left (h)
nmap <Leader>gh :diffget //2<CR>
" Get right (l)
nmap <Leader>gl :diffget //3<CR>

nmap <Leader>gs :G<CR>
" }}}
" }}}

" Colorscheme {{{
try
    colorscheme afterglow
catch
    let g:jinx_theme = 'midnight' " midnight, night, or day
    colorscheme jinx
    " colorscheme slate
endtry
" }}}

" Enable additional features {{{
" Distinguish tabs from spaces and see trailing blanks {{{
set list listchars=tab:>>,trail:~
if $TERM !=? 'linux'
    set termguicolors
    " true colors in terminals (neovim doesn't need this)
    if !has('nvim') && !($TERM =~? 'xterm' || &term =~? 'xterm')
        let $TERM = 'xterm-256color'
        let &term = 'xterm-256color'
    endif
    if has('multi_byte') && $TERM !=? 'linux'
        set listchars=tab:»»,trail:•
        set fillchars=vert:┃ showbreak=↪
    endif
endif
" }}}
" sgr mouse {{{
if has('mouse_sgr')
    " sgr mouse is better but not every term supports it
    set ttymouse=sgr
endif
" }}}
" change cursor shape for different editing modes {{{
" neovim does this by default
if !has('nvim')
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
        let &t_SR = "\<Esc>Ptmux;\<Esc>\e[4 q\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    else
        let &t_SI = "\e[6 q"
        let &t_SR = "\e[4 q"
        let &t_EI = "\e[2 q"
    endif
endif
" }}}
" }}}

" Additional configuration {{{
" netrw {{{
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
" }}}
" Autocmd {{{

" Reload changes if file changed outside of vim requires autoread {{{
augroup load_changed_file
    autocmd!
    autocmd FocusGained,BufEnter * if mode() !=? 'c' | checktime | endif
    autocmd FileChangedShellPost * echo "Changes loaded from source file"
augroup END
" }}}
" when quitting a file, save the cursor position {{{
augroup save_cursor_position
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
" }}}

" when not running in a console or a terminal that doesn't support 256 colors
" enable cursorline in the currently active window and disable it in inactive ones {{{
if $DISPLAY !=? '' && &t_Co == 256
    augroup cursorline
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
endif
" }}}
" }}}
" Commands {{{
command! D Explore
command! R call <SID>ranger()
command! Q call <SID>quitbuffer()
command! -nargs=1 B :call <SID>bufferselect("<args>")
command! W execute 'silent w !sudo tee % >/dev/null' | edit!
" }}}
" Advanced Maps {{{

" Strip trailing whitespace, ss (strip space) {{{
nnoremap <silent> <Leader>ss
    \ :let b:_p = getpos(".") <Bar>
    \  let b:_s = (@/ != '') ? @/ : '' <Bar>
    \  %s/\s\+$//e <Bar>
    \  let @/ = b:_s <Bar>
    \  nohlsearch <Bar>
    \  unlet b:_s <Bar>
    \  call setpos('.', b:_p) <Bar>
    \  unlet b:_p <CR>
" }}}
" Global replace, sw {{{
vnoremap <Leader>sw "hy
    \ :let b:sub = input('global replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   let b:rep = substitute(getreg('h'), '/', '\\/', 'g') <Bar>
    \   execute '%s/'.b:rep."/".b:sub.'/g' <Bar>
    \   unlet b:sub b:rep <Bar>
    \ endif <CR>
nnoremap <Leader>sw
    \ :let b:sub = input('global replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   execute "%s/<C-r><C-w>/".b:sub.'/g' <Bar>
    \   unlet b:sub <Bar>
    \ endif <CR>
" }}}
" Prompt before each replace, cw {{{
vnoremap <Leader>cw "hy
    \ :let b:sub = input('interactive replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   let b:rep = substitute(getreg('h'), '/', '\\/', 'g') <Bar>
    \   execute '%s/'.b:rep.'/'.b:sub.'/gc' <Bar>
    \   unlet b:sub b:rep <Bar>
    \ endif <CR>

nnoremap <Leader>cw
    \ :let b:sub = input('interactive replacement: ') <Bar>
    \ if b:sub !=? '' <Bar>
    \   execute "%s/<C-r><C-w>/".b:sub.'/gc' <Bar>
    \   unlet b:sub <Bar>
    \ endif <CR>
" }}}
" Highlight long lines, ll (long lines) {{{
let w:longlines = matchadd('ColorColumn', '\%'.&textwidth.'v', &textwidth)
nnoremap <silent> <Leader>ll
    \ :if exists('w:longlines') <Bar>
    \   silent! call matchdelete(w:longlines) <Bar>
    \   echo 'Long line highlighting disabled'
    \   <Bar> unlet w:longlines <Bar>
    \ elseif &textwidth > 0 <Bar>
    \   let w:longlines = matchadd('ColorColumn', '\%'.&textwidth.'v', &textwidth) <Bar>
    \   echo 'Long line highlighting enabled'
    \ <Bar> else <Bar>
    \   let w:longlines = matchadd('ColorColumn', '\%80v', 81) <Bar>
    \   echo 'Long line highlighting enabled'
    \ <Bar> endif <CR>
" }}}
" Local keyword jump, fw {{{
nnoremap <Leader>fw
    \ [I:let b:jump = input('Go To: ') <Bar>
    \ if b:jump !=? '' <Bar>
    \   execute "normal! ".b:jump."[\t" <Bar>
    \   unlet b:jump <Bar>
    \ endif <CR>
" }}}

" Functions {{{
" quit the current buffer and switch to the next
" without this vim will leave you on an empty buffer after quiting the current
" quitbuffer() {{{
function! <SID>quitbuffer() abort
    let l:bf = bufnr('%')
    let l:pb = bufnr('#')
    if buflisted(l:pb)
        buffer #
    else
        bnext
    endif
    if bufnr('%') == l:bf
        new
    endif
    if buflisted(l:bf)
        execute('bdelete! ' . l:bf)
    endif
endfunction
" }}}

" switch active buffer based on pattern matching
" if more than one match is found then list the matches to choose from
" bufferselect(pattern) {{{
function! <SID>bufferselect(pattern) abort
    let l:bufcount = bufnr('$')
    let l:currbufnr = 1
    let l:nummatches = 0
    let l:matchingbufnr = 0
    " walk the buffer count
    while l:currbufnr <= l:bufcount
        if (bufexists(l:currbufnr))
            let l:currbufname = bufname(l:currbufnr)
            if (match(l:currbufname, a:pattern) > -1)
                echo l:currbufnr.': '.bufname(l:currbufnr)
                let l:nummatches += 1
                let l:matchingbufnr = l:currbufnr
            endif
        endif
        let l:currbufnr += 1
    endwhile

    " only one match
    if (l:nummatches == 1)
        execute ':buffer '.l:matchingbufnr
    elseif (l:nummatches > 1)
        " more than one match
        let l:desiredbufnr = input('Enter buffer number: ')
        if (strlen(l:desiredbufnr) != 0)
            execute ':buffer '.l:desiredbufnr
        endif
    else
        echoerr 'No matching buffers'
    endif
endfunction
" }}}

" open ranger as a file chooser
" ranger() {{{
function! <SID>ranger()
    let l:temp = tempname()
    execute 'silent !xterm -e ranger --choosefiles='.shellescape(l:temp).' $PWD'
    if !filereadable(temp)
        redraw!
        return
    endif
    let l:names = readfile(l:temp)
    if empty(l:names)
        redraw!
        return
    endif
    execute 'edit '.fnameescape(l:names[0])
    for l:name in l:names[1:]
        execute 'argadd '.fnameescape(l:name)
    endfor
    redraw!
endfunction
" }}}
" }}}

" }}}
" }}}

" Keyboard maps {{{
" open ranger as a file chooser
nnoremap <leader>r :call <SID>ranger()<CR>

" match string to switch buffer
nnoremap <Leader>b :let b:buf = input('Match: ')<Bar>call <SID>bufferselect(b:buf)<CR>

" Windows {{{
" change windows with ctrl+(hjkl)
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Split the window vertically and horizontally
nnoremap _ <C-W>s<C-W><Down>
nnoremap <Bar> <C-W>v<C-W><Right>
" }}}

" Alt defaults {{{
" Normal {{{
nnoremap 0 ^
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
" This disables <C-i> functionality
" nnoremap <Tab> ==1j
" }}}
" Visual {{{
" re-visual text after changing indent
vnoremap > >gv
vnoremap < <gv
" }}}
" }}}


" gj/k but preserve numbered jumps ie: 12j or 45k
nmap <buffer><silent><expr>j v:count ? 'j' : 'gj'
nmap <buffer><silent><expr>k v:count ? 'k' : 'gk'


" Tabs {{{
nnoremap <silent> <M-h> :tabprevious<CR>
nnoremap <silent> <M-j> :tabmove -1<CR>
nnoremap <silent> <M-k> :tabmove +1<CR>
nnoremap <silent> <M-l> :tabnext<CR>
nnoremap <silent> <Leader>te :tabnew<CR>
nnoremap <silent> <Leader>tn :tabnext<CR>
nnoremap <silent> <Leader>tf :tabfirst<CR>
nnoremap <silent> <Leader>tp :tabprevious<CR>

" close current buffer and/or tab
nnoremap <silent> <Leader>q :B<CR>:silent tabclose<CR>gT

" open a new tab in the current directory with netrw
nnoremap <silent> <Leader>- :tabedit <C-R>=expand("%:p:h")<CR><CR>
" }}}

" Neovim terminal {{{
nnoremap <silent> <Leader>tt :terminal<CR>
" Exit from terminal emulator with Esc instead of only with <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
" }}}

" " save with C-s
" nnoremap <C-s> :w<CR>


" User
" autocmd! bufwritepost $MYVIMRC source $MYVIMRC
nmap <Leader>i :tabnew $MYVIMRC<CR>
nmap <Leader>v :source $MYVIMRC<CR>
nmap <Leader>h :nohls<CR>

" No Delay Escape on terminal
set timeoutlen=1000 ttimeoutlen=0

" Latex {{{
autocmd FileType tex inoremap ç \c c
autocmd FileType tex inoremap é \'e
autocmd FileType tex inoremap á \'a
autocmd FileType tex inoremap â \^a
autocmd FileType tex inoremap õ \H o
" }}}
" Python {{{
autocmd FileType python noremap <buffer> <F5> :w! \| !python %<CR>
" }}}
" C {{{
autocmd FileType c noremap <buffer> <F5> :w! \| !make<CR>
" }}}
" C++ {{{
autocmd FileType cpp noremap <buffer> <F5> :w! \| !make<CR>
" }}}
" }}}