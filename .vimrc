" ~/.vimrc
" Author: k3mm0tar http://github.com/k3mm0tar
"
"        ________ ++     ________
"       /VVVVVVVV\++++  /VVVVVVVV\
"       \VVVVVVVV/++++++\VVVVVVVV/
"        |VVVVVV|++++++++/VVVVV/'
"        |VVVVVV|++++++/VVVVV/'
"       +|VVVVVV|++++/VVVVV/'+
"     +++|VVVVVV|++/VVVVV/'+++++
"   +++++|VVVVVV|/VVV___++++++++++
"     +++|VVVVVVVVVV/##/ +_+_+_+_
"       +|VVVVVVVVV___ +/#_#,#_#,\
"        |VVVVVVV//##/+/#/+/#/'/#/
"        |VVVVV/'+/#/+/#/+/#/ /#/
"        |VVV/'++/#/+/#/ /#/ /#/
"        'V/'  /##//##//##//###/
"                 ++
"
syntax on
set nocompatible
filetype on

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

Bundle 'gmarik/vundle'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'morhetz/gruvbox'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ervandew/supertab'
Bundle 'szw/vim-ctrlspace' 
Bundle 'tpope/vim-surround' 
Plugin 'tpope/vim-fugitive'
Plugin 'camelcasemotion'

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

set mousehide                   " Hide mouse when typing
set mouse=a                     " Enable mouse

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
"set foldmethod=indent
"set foldcolumn=1

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
    if &term == 'linux'
        colorscheme desert
    endif
    inoremap <Nul> <C-x><C-o>
    let NERDTreeDirArrows=0
    let NERDTreeShowHidden=1
endif

" Beeps off
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

" Disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Cool stuff
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


set keymap=ukrainian-jcuken     " Ukrainian lang
set iminsert=0
set imsearch=0

" Spell
" [s s] - move
" z= - variants
" h spell
nmap <leader>sua :set spell spelllang=uk<CR>
nmap <leader>sn :set nospell<CR>

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

let g:SuperTabDefaultCompletionType = 'context' "Let SuperTab use other completion for classes and objects

"Search and replace word under curser with F4
nnoremap <F4> :%s/<c-r><c-w>//g<c-f>$F/i

" Let ; work as :
nnoremap ; :

" Map s to camel case w
" map s <Plug>CamelCaseMotion_w 
set completeopt=longest,menuone
let g:EclimCompletionMethod = 'omnifunc'

" Removes error message when navigating away from unsaved buffer
set hidden

"Make it easier to navigate windows]
map <C-h> <C-w>h
"map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" F5 to recursively search directory
map <F5> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

let g:SuperTabContextDefaultCompletionType = "<c-p>"
"Case insensitive filename completion
set wildignorecase

map <C-j><C-i> :JavaImport<Return>
map <C-j><C-g> :JavaGet<Return>
map <C-j><C-s> :JavaSet<Return>
map <C-j><C-c> :JavaConstructor<Return>
map <C-j><C-j> :Java<Return>
map <C-j><C-m> :JavaMove<Space>
map <C-j><C-f> :JavaSearch<Return>
map <C-j><C-h> :JavaCorrect<Return>
map <C-j><C-p> :ProjectProblems<Return>

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

let  g:ctrlspace_default_mapping_key = '<C-p>'
