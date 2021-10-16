"""""""""""""""""""""""""""""
" Repository: accepted-zhs/my-vimrc
" Author: accepted-zhs <huaishazhang@outlook.com>
" License: GPL-3.0
"""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""
" 基础设置
"""""""""""""""""""""""""""""
set encoding=utf-8
syntax enable 
syntax on
filetype on
set nocompatible  
set termguicolors

set autoindent
set cindent
set smartindent
set ts=4
set shiftwidth=4
set softtabstop=4
set expandtab
set foldmethod=marker

set nu
set cursorline
set statusline=2
set noshowmode
set virtualedit=block,onemore
set nowrap
set hlsearch
set incsearch
set wildmenu
set noeb
set splitright              
set splitbelow
set hidden
set cmdheight=2
set switchbuf=useopen,usetab,newtab

set noswapfile
set nobackup
set autowrite
set confirm
set autochdir

set ttimeoutlen=0
set mouse=a
let mapleader='\'

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T

set guifont=FiraCode\ Nerd\ Font\ Mono\ Regular\ 11

vnoremap <leader><leader>y "+y<CR>
nnoremap <leader><leader>p "+p<CR>
nnoremap <leader>c :e $MYVIMRC<CR>
nnoremap <leader>cc :e ~/.vimrc_custom_settings<CR>
nnoremap <leader>cp :e ~/.vimrc_custom_plugins<CR>
nnoremap <leader>s :source $MYVIMRC<CR>

"""""""""""""""""""""""""""""
" 插件们
"""""""""""""""""""""""""""""

""" vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!wget -P '.data_dir.'/autoload/ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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
    Plug 'lifepillar/vim-solarized8'
    Plug 'chriskempson/base16-vim'

    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'
    Plug 'Yggdroot/indentLine'
    " Plug 'Raimondi/delimitMate'
    Plug 'mhinz/vim-startify'
    Plug 'ryanoasis/vim-devicons'
    
    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
    Plug 'simnalamburt/vim-mundo'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " Plug 'tpope/vim-fugitive'
    
    " Plug 'prabirshrestha/asyncomplete-lsp.vim'
    " Plug 'prabirshrestha/asyncomplete.vim'
    " Plug 'prabirshrestha/vim-lsp'
    " Plug 'mattn/vim-lsp-settings'
    " Plug 'dense-analysis/ale'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    if filereadable(expand("~/.vimrc_custom_plugins"))
        source ~/.vimrc_custom_plugins
    endif
call plug#end()

""" colorscheme
colorscheme base16-onedark
set background=dark
let g:airline_theme="onedark"
hi Normal ctermfg=252 ctermbg=None

""" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'default'
nnoremap <silent> <TAB>n :bn<CR>
nnoremap <silent> <TAB>p :bp<CR>
nnoremap <silent> <TAB>d :bd<CR>

""" LeaderF
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

""" NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>

""" coc.nvim
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-vimlsp', 'coc-highlight', 'coc-clangd', 'coc-sh', 'coc-pyright', 'coc-json']

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=500

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1    
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""" Async Single File Compile & Run
" let g:asyncrun_open = 6

func! CompileFile()
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "rows": 6, "focus": 0}
    if &filetype == 'cpp'
        call asyncrun#run("!", opts, "g++ $VIM_FILEPATH -o $VIM_PATHNOEXT -Wall -Wextra -std=c++14 -g -DLOCAL")
    elseif &filetype == 'c'
        call asyncrun#run("!", opts, "gcc $VIM_FILEPATH -o $VIM_PATHNOEXT -Wall -Wextra")
    endif
endfunc

func! RunFile()
    call asyncrun#stop("")
    let opts = {"cwd": $VIM_FILEPATH, "mode": "term", "rows": 6}
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

if filereadable(expand("~/.vimrc_custom_settings"))
    source ~/.vimrc_custom_settings
endif
