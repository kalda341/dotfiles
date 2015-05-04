" ~/.vimrc
" Author: Max Lay
" Much copied from: k3mm0tar http://github.com/k3mm0tar

syntax on
set nocompatible
filetype on

let mapleader = "\<Space>"

"Fix scrolling on wrapped lines
nnoremap j gj
nnoremap k gk

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
Plugin 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plugin 'ctrlp.vim'
Plugin 'tpope/vim-surround' 
"Autocomplete ends of blocks (like if)
Plugin 'tpope/vim-endwise'
"Guess indents based on file and containing directory
Plugin 'tpope/vim-sleuth'
"Need to find time to configure
Plugin 'tpope/vim-repeat'
Plugin 'camelcasemotion'
Plugin 'quickfixsigns'
Plugin 'repeat-motion'
Plugin 'lervag/vim-latex'
"Plugin 'TaskList.vim'
Plugin 'Syntastic'
Plugin 'EasyMotion'
Plugin 'christoomey/vim-tmux-navigator'

"Text objects
Plugin 'kana/vim-textobj-user'
Plugin 'bps/vim-textobj-python'
Plugin 'b4winckler/vim-angry'

"Ultisnips
Plugin 'SirVer/ultisnips', {'do': 'ln -s ~/.vim/bundle/ultisnips/ftdetect/UltiSnips.vim ~/.vim/ftdetect'}
Plugin 'honza/vim-snippets'

"The silver searcher
Plugin 'rking/ag.vim'
Plugin 'majutsushi/tagbar'

Plugin 'tommcdo/vim-exchange'

"Run tmux commands from vim
Plugin 'benmills/vimux'

let vundle_bundles = expand("~/.vim/bundles.vim")
if filereadable(vundle_bundles)
    exec "source " . vundle_bundles
endif

if bundleinstall == 1
    exec "BundleInstall"
endif

set history=200

set termencoding=utf-8
set fileencodings=utf8,cp1251
set encoding=utf8

filetype plugin indent on
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

"Reload file if edits happen somewhere else
set autoread

set mouse=a

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
nmap <Leader>/ :nohlsearch<CR>

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

" For NERDTree
nmap <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.py[co]$', '\~$']

" TList
nmap <F3> :TagbarToggle<CR>

"nnoremap <F4> :ctags -R --exclude=.git<CR>

" Set cursorcolumn
nmap <Leader>scc :set cuc<CR>
nmap <Leader>Scc :set nocuc<CR>

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
noremap <silent> [Q :cfirst<CR>
noremap <silent> ]Q :clast<CR>
noremap <Leader>q :copen<CR>
noremap <Leader>Q :cclose<CR>

" Syntastic
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
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

set completeopt=longest,menuone
let g:EclimCompletionMethod = 'omnifunc'

" Removes error message when navigating away from unsaved buffer
set hidden

"Make it easier to navigate windows]
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Alternate scrolling
map <C-j> 5j
map <C-k> 5k

" F5 to recursively search directory
map <F5> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

"Case insensitive filename completion
set wildignorecase

"Vimrc stuff
nmap <silent> <Leader>ev :tabe $MYVIMRC<CR>
nmap <silent> <Leader>sv :so $MYVIMRC<CR>

" Java
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

"Newline
map <Leader>o o<Esc>
map <Leader>O O<Esc>

"Copy, paste and cut to system clipboard
map <Leader>y "+y
map <Leader>x "+d
map <Leader>p :set paste<CR>"+p:set nopaste<CR>

map <S-W> <Plug>CamelCaseMotion_w
map <S-B> <Plug>CamelCaseMotion_b
map <S-E> <Plug>CamelCaseMotion_e

"Ctrl p
map <C-b> :CtrlPBuffer<CR>
map <Leader>m :CtrlPMRU<CR>

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

"Diffs should be vertically split!
set diffopt+=vertical
set re=1

"%% is directory containing current file
cabbr <expr> %% expand('%:p:h')

"Indent entire document
map <Leader><C-i> mzgg=G'z

" YouCompleteMe setup
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

"Ultisnips Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

map <Leader>td <Plug>TaskList

"fixes terminal draw bug in Tmux
set t_ut=

" Add ranger as a file chooser in vim
" If you add this code to the .vimrc, ranger can be started using the command
" ":RangerChooser" or the keybinding "<Leader>r". Once you select one or more
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
nnoremap <Leader>r :<C-U>RangerChooser<CR>

nmap <Leader>t :TagbarToggle<CR>

let repmo_key=","
let repmo_revkey="\\"
noremap ; "_d

"Disable annoying backup
set nobackup
set noswapfile
nmap <F12> :nohl<CR>

"Sudo write
cmap w!! w !sudo tee % >/dev/null

""Don't keep all fugative buffers open when not shown
"autocmd BufReadPost fugitive://* set bufhidden=delete
