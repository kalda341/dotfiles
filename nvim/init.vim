" ~/.config/nvim/init.vim
" Author: Max Lay
if &compatible
  set nocompatible
endif

let mapleader = "\<Space>"

" Plugins
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  " More precise, faster matcher than CtrlP
  " Respect .gitignore
  let $FZF_DEFAULT_COMMAND = 'rg --files'
  Plug 'junegunn/fzf', {'do': './install --all', 'merged': 0}
  Plug 'junegunn/fzf.vim'
  nmap <C-p> :Files<Cr>
  nmap <C-b> :Buffers<Cr>
  nmap <C-n> :History<Cr>
  let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

  Plug 'tpope/vim-abolish', {'on': ['Abolish', 'Subvert']}

  " Git
  Plug 'mattn/webapi-vim'
  Plug 'mattn/gist-vim', {'on': 'Gist'}
  Plug 'tpope/vim-fugitive'
  " Diffs should be vertically split!
  set diffopt+=vertical

  " Theme
  Plug 'morhetz/gruvbox'
  set background=dark
  set t_Co=256
  autocmd vimenter * colorscheme gruvbox

  " Syntax checking/linting
  " Coc can do this, but ale does it better
  let g:ale_disable_lsp = 1
  Plug 'w0rp/ale'
  " let b:ale_linters = [
  " \ 'prospector',
  " \ 'eslint', 'typescript',
  " \ 'ember-template-lint',
  " \ 'stylelint'
  " \ ]
  let g:ale_sign_column_always = 1
  let g:ale_sign_error = '✘'
  let g:ale_sign_warning = '!'

  " LSP support
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Show function signature, etc
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

  " Symbol renaming.
  nmap <leader>rr <Plug>(coc-rename)
  " File renaming.
  nmap <leader>rf :CocCommand workspace.renameCurrentFile<CR>

  " Formatting selected code
  nmap <leader>ff <Plug>(coc-format)
  xmap <leader>f <Plug>(coc-format-selected)
  nmap <leader>f <Plug>(coc-format-selected)

  " Typescript specific build
  command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild')

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

  " Coc Explorer
  nmap <F2> :CocCommand explorer<CR>
  autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

  " Language support
  Plug 'sheerun/vim-polyglot'

  " Plug 'Raimondi/delimitMate'
  " let delimitMate_expand_cr = 1
  " let delimitMate_expand_space = 1

  " Actions
  Plug 'scrooloose/nerdcommenter'
  let NERDSpaceDelims=1

  Plug 'FooSoft/vim-argwrap'
  " Arguments on new lines
  map <silent> <leader>a :ArgWrap<CR>

  " Fixes increment and decrement for dates/times
  Plug 'tpope/vim-speeddating'

  " Motions
  Plug 'tpope/vim-surround'

  " Text objects
  " Adds a huge number of text objects
  Plug 'wellle/targets.vim'
  " Allows simple selection of text objects (eg. viv)
  Plug 'gorkunov/smartpairs.vim'

  " Filetypes
  " Guess indents based on file and containing directory
  Plug 'tpope/vim-sleuth'
  " Respect editorconfig
  Plug 'editorconfig/editorconfig-vim'

  " Traverse the undo/redo tree
  Plug 'mbbill/undotree'
  nnoremap <F3> :UndotreeToggle<CR>
call plug#end()

" Improve startup time
set guioptions=M

" General
syntax on
filetype on
filetype plugin on
filetype indent on
" Disable safe write to fix autoreload with Parcel
set backupcopy=yes
set shell=/bin/bash
" Uncomment for mouse support
" set mouse=a
" Fix backspace
set backspace=indent,eol,start
" Disable ex mode
map q: <Nop>
nnoremap Q <nop>
" Increase command history
set history=200
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
" Suggested by coc
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" Suggested by coc
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use ; as :
nnoremap ; :
" Removes error message when navigating away from unsaved buffer
set hidden
" Saving
nmap <Leader>w :w!<cr>
" Sudo write
cmap w!! w !sudo tee % >/dev/null
" Reload file if edits happen somewhere else
set autoread
"Auto resize panes on terminal resize
autocmd VimResized * wincmd =

" Terminal setup
set termencoding=utf-8
set fileencodings=utf8,cp1251
set encoding=utf8
" fixes terminal draw bug in Tmux
set t_ut=
" Beeps off, not that I ever use a terminal that does
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

set autoindent
" Jump to nearest indentation
set shiftround

" Statusline stuff
" Give more space for displaying messages.
" set cmdheight=2
" Display status line always
set laststatus=2
set ruler
set showcmd

" Ignore some file types
set wildmenu
set wildignorecase
" %% is directory containing current file
cabbr <expr> %% expand('%:p:h')
set wildignore+=.hg,.git,.svn
set wildignore+=*.pyc
set wildignore+=venv
set wildignore+=*.beam
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.class,*.o

" Display whitespace
set listchars=tab:>.,trail:.
set list

" Line numbers and limits
set number                      " Show line numbers
set relativenumber
set cc=120                       " Ver line in 120 column
set cursorline

" Search
set hlsearch                    " Highlight searches
set incsearch                   " Highlight dynamically as pattern is typed
set smartcase                   " Ignore case of searches unless they contain an uppercase character
" Leader / to clear search highligting
nmap <Leader>/ :nohlsearch<CR>

" Allows undo after file is closed
if exists("&undodir")
    set undofile
    set undodir=/tmp
endif
" Swap files and backup are super annoying. I save often
set noswapfile
set nobackup

" Movement
set scrolloff=8                 " Start scrolling n lines before border
" Scroll wrapped lines normally
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
" End of line
inoremap <C-e> <C-o>$
" Start of line
inoremap <C-a> <C-o>^

"Easy ways of getting into normal mode
inoremap kk <ESC>
inoremap jj <ESC>

" Spelling
" Pressing ,ss will toggle and untoggle spell checking
setlocal spell spelllang=en_gb
setlocal nospell
map <leader>ss :setlocal spell!<cr>
" Add word to spellfile
map <leader>sa zg
" Suggest spelling
map <leader>s? z=

" Make it easier to navigate windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" The moving commands don't align perfectly (and we can't use shift)
" but make them behave similar to i3/sway
map <Leader><C-h> <C-w>R
map <Leader><C-j> <C-w>R
map <Leader><C-k> <C-w>r
map <Leader><C-l> <C-w>r

" Vimrc shortcuts
nmap <silent> <Leader>ev :ed $MYVIMRC<CR>

" Newline
map <Leader>o o<Esc>
map <Leader>O O<Esc>

" Copy, paste and cut to system clipboard
map <Leader>y "+y
map <Leader>d "+d
map <Leader>p :set paste<CR>"+p:set nopaste<CR>
map <Leader>P :set paste<CR>"+P:set nopaste<CR>

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
map <Leader>q :call ToggleQuickFix()<CR>
