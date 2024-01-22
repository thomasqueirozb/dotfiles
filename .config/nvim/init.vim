" vim:foldmethod=marker

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
set shortmess+=aAcIws  " Hide or shorten certain messages
set undofile           " Persistent undo
set hidden             " Change buffer without saving
set linebreak          " Long line wrapping
set breakindent        " Indent is the same for wrapped line
set expandtab          " Tab key inserts spaces not tabs
set smarttab           " smart tabs
set tabstop=4          " Width used for tabs
set softtabstop=4      " spaces to enter for each tab
set shiftwidth=4       " amount of spaces for indentation

set mouse=a            " enable mouse
syntax enable          " syntax highlighting
set foldmethod=syntax
set foldlevel=1
" }}}

" Plugins {{{
" vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')
" Unused {{{
" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" }}}

" Themes {{{
" Status line {{{
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }}}
" Colorschemes {{{
Plug 'danilo-augusto/vim-afterglow' " Afterglow
" Plug 'dracula/vim', { 'as': 'dracula' } " Dracula
Plug 'gruvbox-community/gruvbox' " Gruvbox
" }}}
" }}}

" Linters/Fixers {{{
Plug 'dense-analysis/ale' " I use this mostly for fixing
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'maksimr/vim-jsbeautify'
Plug 'editorconfig/editorconfig-vim'
" }}}

" Folds {{{
Plug 'Konfekt/FastFold'
Plug 'kalekundert/vim-coiled-snake' " Python fold
" }}}

" Fugitive - git {{{
Plug 'tpope/vim-fugitive'
" }}}

" Language support {{{
Plug 'lervag/vimtex' " TODO

Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'vim-python/python-syntax'

" Plug 'tomlion/vim-solidity'
" }}}

" Other {{{
Plug 'tpope/vim-commentary'
" }}}
call plug#end()
" }}}

" ALE {{{
let g:ale_linters = {
    \'asm': [],
    \'c': [],
    \'cpp': [],
    \'cuda': ['clangd'],
    \'javascript': [],
    \'markdown': [],
    \'python': ['pylint'],
    \'rust': [],
    \'sh': ['shellcheck'],
    \'typescript': ['eslint', 'tsserver', 'prettier'],
    \'vue': ['eslint'],
    \}

let g:ale_fixers = {
    \'c': ['clang-format'],
    \'cpp': ['clang-format'],
    \'css': ['prettier'],
    \'cuda': ['clang-format'],
    \'javascript': ['eslint'],
    \'json': ['prettier'],
    \'markdown': ['prettier'],
    \'python': ['black'],
    \'rust': [],
    \'sh': [],
    \'typescript': ['eslint'],
    \'vue': ['eslint'],
    \}
let g:ale_fix_on_save=1

let g:ale_python_pylint_options='--disable=C0114,C0115,C0116,fixme'
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
let g:ale_cuda_clangformat_options='--style="{' . g:clang_format_options . '}"'


let g:ale_cuda_clangd_options="-std=c++11 -x c++"



" }}}
" COC {{{

" :CocInstall coc-marketplace
" To have :CocList marketplace
" Learn more @ github.com/fannheyward/coc-marketplace
" coc-tsserver
" coc-rust-analyzer
" coc-python
" coc-json
" coc-html
" coc-diagnostic
"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

nmap <Leader>gd <Plug>(coc-definition)
nmap <Leader>gy <Plug>(coc-type-definition)
nmap <Leader>gi <Plug>(coc-implementation)
nmap <Leader>gr <Plug>(coc-references)
nmap <Leader>rr <Plug>(coc-rename)
nmap <Leader>g[ <Plug>(coc-diagnostic-prev)
nmap <Leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>gn <Plug>(coc-diagnostic-next)
nnoremap <Leader>cr :CocRestart<CR>

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
" EditorConfig{{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
"}}}
" {{{ Python syntax
let g:python_highlight_builtins = 1
" g:python_highlight_builtin_objs             | Highlight builtin objects only                                 | 0     |
" g:python_highlight_builtin_types            | Highlight builtin types only                                   | 0     |
" g:python_highlight_builtin_funcs            | Highlight builtin functions only                               | 0     |
" g:python_highlight_builtin_funcs_kwarg      | Highlight builtin functions when used as kwarg                 | 1     |
" g:python_highlight_exceptions               | Highlight standard exceptions                                  | 0     |
let g:python_highlight_string_formatting = 1
let g:python_highlight_string_format = 1
let g:python_highlight_string_templates = 1
let g:python_highlight_space_errors = 0
let g:python_highlight_doctests = 1
let g:python_highlight_func_calls = 1
let g:python_highlight_class_vars = 1
" g:python_highlight_operators                | Highlight all operators                                        | 0     |
let g:python_highlight_file_headers_as_comments = 0
" }}}
" {{{ Coiled Snake - Python fold
function! g:CoiledSnakeConfigureFold(fold)

    " Don't fold nested classes.
    if a:fold.type == 'class'
        let a:fold.max_level = 1

    " Don't fold nested functions, but do fold methods (i.e. functions nested inside a class).
    elseif a:fold.type == 'function'
        let a:fold.max_level = 1
        if get(a:fold.parent, 'type', '') == 'class'
            let a:fold.max_level = 2
        endif

    " Only fold imports if there are 3 or more of them.
    elseif a:fold.type == 'import'
        let a:fold.min_lines = 3
    endif

    " " Don't fold anything if the whole program is shorter than 30 lines.
    " if line('$') < 30
    "     let a:fold.ignore = 1
    " endif

endfunction
" }}}
" vimtex {{{
let g:tex_flavor = 'latex'
" }}}
" Rust {{{
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
" }}}
" Commentary {{{
autocmd FileType c setlocal commentstring=//%s
autocmd FileType c++ setlocal commentstring=//%s
autocmd FileType cuda setlocal commentstring=//%s
autocmd FileType vue setlocal commentstring=<!--%s-->
autocmd FileType vhdl setlocal commentstring=--%s
"autocmd FileType asm setlocal commentstring=\;%s
"
function CommentaryWithCursor()
    let line_number = line('.')
    let old_col = col('.')
    let old_size = strwidth(getline('.'))

    Commentary

    " A space is inserted so + 1 is needed
    let split_len = strlen(split(&commentstring, "%s")[0]) + 1

    if strlen(getline('.')) > old_size
        call cursor(line_number, old_col + split_len)
    else
        call cursor(line_number, old_col - split_len)
    endif
endfunction

inoremap <C-_> <C-o>:call CommentaryWithCursor()<CR>
" nmap <C-_> <Plug>CommentaryLine
nnoremap <C-_> :call CommentaryWithCursor()<CR>
vmap <C-_> <Plug>Commentarygv
" }}}
" }}}

" Colorscheme {{{
try
    " let g:gruvbox_contrast_dark = 'hard'
    colorscheme gruvbox
catch
try
    colorscheme afterglow
    hi Pmenu guibg=#2b2e33 gui=NONE
catch
    let g:jinx_theme = 'midnight' " midnight, night, or day
    colorscheme jinx
    " colorscheme slate
endtry
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
        set listchars=tab:»»,trail:• " tabs:	trailing spaces: 
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
" xdg {{{
if !has('nvim')
    set runtimepath^=$XDG_CONFIG_HOME/vim
    set runtimepath+=$XDG_DATA_HOME/vim
    set runtimepath+=$XDG_CONFIG_HOME/vim/after

    set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
    set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

    let g:netrw_home = $XDG_DATA_HOME."/vim"
    call mkdir($XDG_DATA_HOME."/vim/spell", 'p')
    set viewdir=$XDG_DATA_HOME/vim/view | call mkdir(&viewdir, 'p')

    set backupdir=$XDG_CACHE_HOME/vim/backup | call mkdir(&backupdir, 'p')
    set directory=$XDG_CACHE_HOME/vim/swap   | call mkdir(&directory, 'p')
    set undodir=$XDG_CACHE_HOME/vim/undo     | call mkdir(&undodir,   'p')
    set viminfofile=$XDG_CACHE_HOME/vim/viminfo
endif
" }}}
" netrw {{{
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
" }}}
" Autocmd {{{
" Highlight keywords {{{
function! SetMyHighlights()
    syntax keyword myTodo TODO CRITICAL WARNING OPTIMIZE FIXME containedin=ALL

    hi def link myTodo Todo
endfunction
autocmd bufenter * :call SetMyHighlights()
autocmd filetype * :call SetMyHighlights()

" autocmd Syntax * syntax keyword myTodo WARNING NOTES containedin=ALL | highlight def link myTodo TODO

" }}}

" Reload changes if file changed outside of vim requires autoread {{{
augroup load_changed_file
    autocmd!
    autocmd FocusGained,BufEnter * if mode() !=? 'c' | checktime | endif
    autocmd FileChangedShellPost * echo "Changes loaded from source file"
augroup END
" }}}
" Save the cursor position on file exit {{{
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
nnoremap <Leader>r :call <SID>ranger()<CR>

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

" No Delay Escape on terminal
set timeoutlen=1000 ttimeoutlen=0
" }}}

" User
" autocmd! bufwritepost $MYVIMRC source $MYVIMRC
nmap <Leader>i :tabnew $MYVIMRC<CR>
nmap <Leader>v :source $MYVIMRC<CR>
nmap <Leader>h :nohls<CR>

" Don't copy text when deleting
nmap <Leader>x "_x
nmap <Leader>d "_d

vmap <Leader>x "_x
vmap <Leader>d "_d

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

if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    set guifont=UbuntuMono\ Nerd\ Font\ Mono:h12
    let g:neovide_cursor_animate_command_line = v:false
endif
