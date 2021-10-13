"""""""""""""""""""""""""""""
" Repository: accepted-zhs/my-vimrc
" Author: accepted-zhs <huaishazhang@outlook.com>
" License: GPL-3.0
"""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""
" 基础设置
"""""""""""""""""""""""""""""
syntax enable 
syntax on
filetype on
set nocompatible  

set autoindent
set cindent
set smartindent
set ts=4
set shiftwidth=4
set softtabstop=4
set expandtab

set nu
set cursorline
set virtualedit=block,onemore
set nowrap
set hlsearch
set incsearch
set wildmenu
set noeb

set noswapfile
set nobackup
set autowrite
set confirm
set autochdir

set ttimeoutlen=0
set mouse=a
let mapleader='\'

nnoremap <leader><leader>y "+y<CR>
nnoremap <leader><leader>p "+p<CR>
nnoremap <leader>c :e $MYVIMRC<CR>
" nnoremap <leader>cc 
" nnoremap <leader>cp

"""""""""""""""""""""""""""""
" 插件们
"""""""""""""""""""""""""""""

""" vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!wget -P '.data_dir.'/autoload/ https://raw.githubusercontents.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
\| endif

""" plugins
call plug#begin('~/.vim/plugged')
    Plug 'joshdick/onedark.vim'
    Plug 'tomasr/molokai'
    Plug 'ashfinal/vim-colors-violet'
    " Plug 'lifepillar/vim-solarized8'

    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'
    Plug 'Yggdroot/indentLine'
    Plug 'Raimondi/delimitMate'
    Plug 'mhinz/vim-startify'
    Plug 'ryanoasis/vim-devicons'
    
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'simnalamburt/vim-mundo'
    Plug 'preservim/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'skywind3000/asyncrun.vim'
    
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
        " Plug 'dense-analysis/ale'
call plug#end()

""" colorscheme
colorscheme violet
set background=dark
" let g:airline_theme="onedark"
hi Normal ctermfg=252 ctermbg=None

""" vim-airline
let g:airline#extensions#tabline#enabled = 1
nnoremap <leader>p :bp<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>d :bd<CR>

""" fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>ft :Helptags<CR>
nnoremap <leader>fe :History<CR>
nnoremap <leader>ft :Tags<CR>

""" Single File Compile & Run
func! CompileFile()
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "rows": 8, "focus": 0}
    if &filetype == 'cpp'
        call asyncrun#run("!", opts, "g++ $VIM_FILEPATH -o $VIM_PATHNOEXT -Wall -Wextra -std=c++14 -g")
    elseif &filetype == 'c'
        call asyncrun#run("!", opts, "gcc $VIM_FILEPATH -o $VIM_PATHNOEXT -Wall -Wextra")
    endif
endfunc

func! RunFile()
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "rows": 8, "focus": 0}
    if &filetype == 'cpp' || &filetype == 'c'
        call asyncrun#run("!", opts, "time $VIM_PATHNOEXT")
    elseif &filetype == 'python'
        call asyncrun#run("!", opts, "python3 -u $VIM_FILEPATH")
    elseif &filetype == 'sh'
        call asyncrun#run("!", opts, "bash $VIM_FILEPATH")
    endif
endfunc

nnoremap <F5> :call CompileFile()<CR>
nnoremap <F6> :call RunFile()<CR>

