" ~/.vimrc
" Author: Max Lay
" Much copied from: k3mm0tar http://github.com/k3mm0tar

syntax on
set nocompatible
filetype on

let mapleader = "\<Space>"

let bundleinstall = 0
let bundle = expand('~/.vim/bundle')
if !isdirectory(bundle)
    echo "Installing Vundle"
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    echo "Vundle is now installed!"
    let bundleinstall = 1
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"Don't remember what commented plugins do
Plugin 'gmarik/vundle'

"Git plugins
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'tpope/vim-fugitive'

"Erlang
Plugin 'jimenezrick/vimerl'

"Plugin 'mattn/webapi-vim'
Plugin 'morhetz/gruvbox'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlp.vim'
Plugin 'tpope/vim-surround' 
"Autocomplete ends of blocks (like if)
Plugin 'tpope/vim-endwise'
"Guess indents based on file and containing directory
Plugin 'tpope/vim-sleuth'
"Need to find time to configure
Plugin 'tpope/vim-repeat'
Plugin 'camelcasemotion'
"Plugin 'quickfixsigns'
Plugin 'repeat-motion'
Plugin 'lervag/vim-latex'
"Plugin 'TaskList.vim'
Plugin 'Syntastic'
Plugin 'EasyMotion'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kana/vim-textobj-user'
Plugin 'bps/vim-textobj-python'
"For argument text object
Plugin 'b4winckler/vim-angry'
"Ultisnips
Plugin 'SirVer/ultisnips'
"Utilisnips Snippets
Plugin 'honza/vim-snippets'

let vundle_bundles = expand("~/.vim/bundles.vim")
if filereadable(vundle_bundles)
    exec "source " . vundle_bundles
endif

if bundleinstall == 1
    exec "BundleInstall"
endif

filetype plugin indent on

set history=200

set termencoding=utf-8
set fileencodings=utf8,cp1251
set encoding=utf8

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set autoindent

set autoread

set mouse=a

"set nowrap                        " NoWrap

set laststatus=2

set ruler
set showcmd
set ch=1

set wildmenu                    " Cool cmd completion
set wildignore+=.hg,.git,.svn   " Version control
set wildignore+=*.pyc           " Python byte code
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.class,*.o

set listchars=tab:>.,trail:.
set list

set number                      " Show line numbers
set cc=80                       " Ver line in 80 column
set cursorline
" Set cursorcolumn
nmap <Leader>scc :set cuc<CR>
nmap <Leader>Scc :set nocuc<CR>

set showtabline=1

" Folds
set foldmethod=indent
set foldcolumn=1
set foldlevel=99

set scrolloff=5                 " Start scrolling n lines before border

" Search
set hlsearch                    " Highlight searches
set incsearch                   " Highlight dynamically as pattern is typed
set ignorecase                  " Ignore case of searches
nmap <F12> :nohl<CR>

if exists("&undodir")
    set undofile
    set undodir=/tmp
endif
set noswapfile

set background=dark

" GVim
if has('gui_running')
    colorscheme gruvbox
    set guioptions-=e
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=l
    set guioptions-=R
    set guioptions-=r
    nnoremap <Leader>gm :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
    nnoremap <Leader>gt :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
    inoremap <C-Space> <C-x><C-o>
else
    set t_Co=256
    colorscheme gruvbox
    inoremap <Nul> <C-x><C-o>
    let NERDTreeDirArrows=0
    let NERDTreeShowHidden=1
endif

" Beeps off
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

"Easy ways of getting into normal mode
inoremap jj <ESC>
inoremap jk <ESC>

" Disable help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Open vimrc
nnoremap <F1> :tabe $MYVIMRC<CR>
" Source vimrc
nnoremap <S-F1> :source $MYVIMRC<CR>

" For NERDTree
nmap <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.py[co]$', '\~$']

" TList
nmap <F3> :TagbarToggle<CR>

nnoremap <F4> :!ctags -R --exclude=.git<CR>

map <F7> mzgg=G`z<CR>

noremap <silent> [a :prev<CR>
noremap <silent> ]a :next<CR>
noremap <silent> [A :first<CR>
noremap <silent> ]A :last<CR>
noremap <Leader>a :args<CR>

noremap <silent> [b :bprevious<CR>
noremap <silent> ]b :bnext<CR>
noremap <silent> [B :bfirst<CR>
noremap <silent> ]B :blast<CR>
noremap <Leader>b :ls<CR>:

noremap <silent> [q :cprev<CR>
noremap <silent> ]q :cnext<CR>
noremap <Leader>q :copen<CR>
noremap <Leader>Q :cclose<CR>

" Syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_check_on_open=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" FileType
let python_highlight_all = 1
let g:pyindent_open_paren = '&sw'

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

autocmd FileType python nnoremap <F5> :w<CR>:!python %<CR>
" let f=expand("%") | vnew | execute ".!python ".f
autocmd FileType python setlocal complete-=i
autocmd FileType python setlocal dictionary=~/.vim/dict/python
autocmd FileType python setlocal complete+=k

autocmd FileType html,htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd BufEnter *html map <F11> :setfiletype htmldjango<CR>
autocmd BufEnter *html map <S-F11> :setfiletype django<CR>

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
if 'VIRTUAL_ENV' in os.environ:
    virtualenv_dir = os.environ['VIRTUAL_ENV']
    project_dir    = os.getcwd()
    sys.path.insert(0, project_dir)
    activate_this = os.path.join(
        virtualenv_dir,
        'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

"Search and replace word under curser with F4
nnoremap <F4> :%s/<c-r><c-w>//g<c-f>$F/i

" Map s to camel case w
set completeopt=longest,menuone
let g:EclimCompletionMethod = 'omnifunc'

" Removes error message when navigating away from unsaved buffer
set hidden

"Make it easier to navigate windows]
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" F5 to recursively search directory
map <F5> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

"Case insensitive filename completion
set wildignorecase

map <Leader>o :CtrlP<Return>

map <Leader>ji :JavaImport<Return>
map <Leader>jg :JavaGet<Return>
map <Leader>js :JavaSet<Return>
map <Leader>jc :JavaConstructor<Return>
map <Leader>jj :Java<Return>
map <Leader>jm :JavaMove<Space>
map <Leader>jf :JavaSearch<Return>
map <Leader>jh :JavaCorrect<Return>
map <Leader>jp :ProjectProblems<Return>
map <Leader>jd :JavaDocPreview<Return>

"Copy, paste and cut to system clipboard
map <Leader>y "+y
map <Leader>x "+d
map <Leader>p "+p"

map <S-W> <Plug>CamelCaseMotion_w
map <S-B> <Plug>CamelCaseMotion_b
map <S-E> <Plug>CamelCaseMotion_e

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

"Diffs should be vertically split!
set diffopt+=vertical
set re=1

hi CtrlSpaceSelected term=reverse ctermfg=187  ctermbg=23  cterm=bold
hi CtrlSpaceNormal   term=NONE    ctermfg=244  ctermbg=232 cterm=NONE
hi CtrlSpaceSearch   ctermfg=220  ctermbg=NONE cterm=bold
hi CtrlSpaceStatus   ctermfg=230  ctermbg=234  cterm=NONE

"%% is directory containing current file
cabbr <expr> %% expand('%:p:h')

"Indent entire document
map <C-i> mzgg=G'z


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-@>"
let g:UltiSnipsJumpForwardTrigger="<c-@>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

map <leader>td <Plug>TaskList

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

"fixes terminal draw bug in Tmux
set t_ut=

let g:argumentobject_force_toplevel = 1


" Add ranger as a file chooser in vim
" If you add this code to the .vimrc, ranger can be started using the command
" ":RangerChooser" or the keybinding "<leader>r". Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.
function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

let repmo_key=","
let repmo_revkey="\\"
noremap ; "_d
