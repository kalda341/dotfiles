" ~/.vimrc
" Author: Max Lay
" Much copied from: k3mm0tar http://github.com/k3mm0tar

syntax on
set nocompatible
filetype on

"Easy ways of getting into normal mode
inoremap jj <ESC>
inoremap kk <ESC>
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

"Use local config if available
if filereadable("~/.vimrc.local")
    so ~/.vimrc.local
endif

Plugin 'gmarik/vundle'
"Git plugins
Plugin 'mattn/gist-vim'
"Gist
Plugin 'mattn/webapi-vim'
Plugin 'tpope/vim-fugitive'
"Erlang
Plugin 'jimenezrick/vimerl'
"Best theme ever
Plugin 'morhetz/gruvbox'
""Autocompletion of quotes, brackets, etc
"Plugin 'Raimondi/delimitMate'
"File browser
Plugin 'scrooloose/nerdtree'
"For commenting lines
Plugin 'scrooloose/nerdcommenter'
"Autocomplete
Plugin 'Valloric/YouCompleteMe', { 'do': './install.sh' }
"Easy file and buffer selection
Plugin 'ctrlp.vim'
"For dealing with surrounds
Plugin 'tpope/vim-surround' 
"Guess indents based on file and containing directory
Plugin 'tpope/vim-sleuth'
"Need to find time to configure. For . key
Plugin 'tpope/vim-repeat'
""Handy plugin for moving through camel case words
"Plugin 'camelcasemotion'
"Show errors, marks, etc in margin
Plugin 'quickfixsigns'
"Map , to the last motion
Plugin 'repeat-motion'
"Manage TODOs
"Plugin 'TaskList.vim'
"Syntax checker
Plugin 'Syntastic'
"For easily moving through a file
Plugin 'EasyMotion'
"Integration with tmux windows
Plugin 'christoomey/vim-tmux-navigator'
"The silver searcher
Plugin 'rking/ag.vim'
"For working with Ctags
Plugin 'majutsushi/tagbar'
"For swapping positions of text objects
Plugin 'tommcdo/vim-exchange'
"Run tmux commands from vim
Plugin 'benmills/vimux'

""Text objects
Plugin 'kana/vim-textobj-user'
Plugin 'bps/vim-textobj-python'
Plugin 'b4winckler/vim-angry'

"Ultisnips
Plugin 'SirVer/ultisnips', {'do': 'mkdir ~/.vim/ftdetect && ln -s ~/.vim/bundle/ultisnips/ftdetect/UltiSnips.vim ~/.vim/ftdetect'}
Plugin 'honza/vim-snippets'


let vundle_bundles = expand("~/.vim/bundles.vim")
if filereadable(vundle_bundles)
    exec "source " . vundle_bundles
endif

if bundleinstall == 1
    exec "BundleInstall"
endif

set history=200

"Terminal setup
set termencoding=utf-8
set fileencodings=utf8,cp1251
set encoding=utf8
"fixes terminal draw bug in Tmux
set t_ut=
"Beeps off, not that I ever use a terminal that does
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif


"Indentation and tabs
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab
"Indent entire document
map <Leader><C-i> mzgg=G'z

"Reload file if edits happen somewhere else
set autoread

"Uncomment for mouse support
"set mouse=a

"Statusline stuff
"Display status line always
set laststatus=2
set ruler
set showcmd
set ch=1

"Ignore some file types
set wildmenu                    " Cool cmd completion
set wildignorecase
"%% is directory containing current file
cabbr <expr> %% expand('%:p:h')
set wildignore+=.hg,.git,.svn   " Version control
set wildignore+=*.pyc           " Python byte code
set wildignore+=*.beam           " Erlang byte code
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.class,*.o

"Display whitespace
set listchars=tab:>.,trail:.
set list

"Line numbers and limits
set number                      " Show line numbers
set cc=80                       " Ver line in 80 column
set cursorline

"Folds
set foldmethod=indent
set foldcolumn=1
set foldlevel=99

"Scrolling
set scrolloff=5                 " Start scrolling n lines before border
"Scroll wrapped lines normally
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
"Alternate scrolling
map j 5j
map k 5k
map h 5h
map l 5l

"Search
set hlsearch                    " Highlight searches
set incsearch                   " Highlight dynamically as pattern is typed
set ignorecase                  " Ignore case of searches
nmap <Leader>/ :nohlsearch<CR>

"Allows undo after file is closed
if exists("&undodir")
    set undofile
    set undodir=/tmp
endif
"Swap files and backup are super annoying. I save often
set noswapfile
set nobackup

"Theme
set background=dark
set t_Co=256
colorscheme gruvbox

"Nerdtree file browser
let NERDTreeDirArrows=0
let NERDTreeShowHidden=1
nmap <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.py[co]$', '\~$']

"Tagbar
nmap <Leader>t :TagbarToggle<CR>

"Set cursorcolumn
nmap <Leader>scc :set cuc<CR>
nmap <Leader>Scc :set nocuc<CR>

"Buffers
noremap <silent><Leader>bp :bprevious<CR>
noremap <silent><Leader>bn :bnext<CR>
noremap <silent><Leader>bc :bd<CR>

"Tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

"Changlist
noremap <silent><Leader>cp :cprev<CR>
noremap <silent><Leader>cn :cnext<CR>

"Quickfix
noremap <Leader>q :copen<CR>
noremap <Leader>Q :cclose<CR>

"Diff
map <leader>gd :Gdiff<cr>
map <leader>gs :Gstatus<cr>
map <leader>gb :Gblame<cr>
map <leader>gw! :Gwrite!<cr>

"Spelling
"Pressing ,ss will toggle and untoggle spell checking
setlocal spell spelllang=en_gb
setlocal nospell
map <leader>ss :setlocal spell!<cr>
"Next, previous
map <leader>sn ]s
map <leader>sp [s
"Add word to spellfile
map <leader>sa zg
"Suggest spelling
map <leader>s? z=

"Delete surrounding function
nmap <silent> dsf ds)db

" Syntastic
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"FileTypes
"web
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html,htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd BufEnter *html map <F11> :setfiletype htmldjango<CR>
autocmd BufEnter *html map <S-F11> :setfiletype django<CR>
"Python
let python_highlight_all = 1
"Fix double indentation
let g:pyindent_open_paren = '&sw'
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python nnoremap <F5> :w<CR>:!python %<CR>
autocmd FileType python setlocal complete-=i
autocmd FileType python setlocal complete-=i
autocmd FileType python setlocal dictionary=~/.vim/dict/python
autocmd FileType python setlocal complete+=k
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
"Remove trailing whitespace upon saving python file
autocmd BufWritePre *.py :%s/\s\+$//e

"Add the virtualenv's site-packages to vim path
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

"Removes error message when navigating away from unsaved buffer
set hidden

"Make it easier to navigate windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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
map <Leader>P :set paste<CR>"+P:set nopaste<CR>

"Tasklist
map <Leader>td <Plug>TaskList

"Camel case motion
"map <S-W> <Plug>CamelCaseMotion_w
"map <S-B> <Plug>CamelCaseMotion_b
"map <S-E> <Plug>CamelCaseMotion_e

"Ctrl p
map <C-b> :CtrlPBuffer<CR>
map <C-m> :CtrlPMRU<CR>

"Delimitmate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

"Diffs
"Diffs should be vertically split!
set diffopt+=vertical
set re=1

" YouCompleteMe setup
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

"Ultisnips Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"Repeat motion
let repmo_key=","
let repmo_revkey="\\"

"Use ; as :
nnoremap ; :

"Saving
nmap <Leader>w :w!<cr>
"Sudo write
cmap w!! w !sudo tee % >/dev/null

"cd
map <Leader>cd :cd %:p:h<cr>:pwd<cr>
