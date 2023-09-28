"----------------------------------------------------------------------
" Vim Configuration Start
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" General Configuration
"----------------------------------------------------------------------
" Set map leader for extra key combinations
let mapleader = ","

" Set vim to be vim instead of vi
set nocompatible

" Keep 500 lines of command line history
set history=500

" Enable filetype configuration
filetype plugin on
filetype indent on

" Set auto read / write
set autoread       " auto read when a file is changed from the outside
set autowrite      " write a modified buffer on each :next , ...
au FocusGained,BufEnter * checktime

" Stop highlight when <leader><cr>
map <silent><leader><cr> :noh<cr>

" Move lines up / down
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Go across files
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep indent selection
vnoremap < <gv
vnoremap > >gv

" Some enhancement for copy & paste
noremap <leader>p "_dP
noremap <leader>y "*y

" Stop netrw create hist file
let g:netrw_dirhistmax = 0

"----------------------------------------------------------------------
" Vim User Interface
"----------------------------------------------------------------------
" Set number
set number
set relativenumber

" Search Setting
set hlsearch       " highlight search results
set incsearch      " do incremental searching

set smartcase      " try to be smart about cases
set ignorecase     " ignore case when searching

" Set backspace
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" Set various details
set so=7           " keep 7 lines to the cursor - when moving vertically using j/k
set ruler          " show current position
set mouse=a        " enable the use of mouse
set showcmd        " display incomplete commands

" Set bracket details
set showmatch      " briefly jump to the matching bracket
set matchtime=2    " tenths of a second to show the matching bracket

" Set wrap details
set wrap           " wrap long lines
set linebreak      " wrap on word boundary

" Command line completion in an enhanced mode
set wildmenu

set wildignore=*.bak,*.o,*.e,*~,*.pyc " ignore compiled files
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Change the working directory to the directory containing the current file
if has('autochdir')
    set autochdir
endif

" Stop annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

if has("gui_macvim") " disable sound on errors on MacVim
    autocmd GUIEnter * set vb t_vb=
endif

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"----------------------------------------------------------------------
" Indentation Related
"----------------------------------------------------------------------
set autoindent     " copy indent from current line
set smartindent    " smart indent enable

set shiftwidth=4   " 1 tab == 4 spaces
set tabstop=4      " 1 tab == 4 spaces

set expandtab      " use spaces instead of tabs
set smarttab       " smart tabs enable

set cino=N-s       " do not indent c++ namespace

"----------------------------------------------------------------------
" Colors and Fonts
"----------------------------------------------------------------------
" Enable syntax highlighting
syntax enable
" colorscheme sublimemonokai

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" C++ template <> angle bracket
set matchpairs+=<:>

"----------------------------------------------------------------------
" Files, Backups and Undo
"----------------------------------------------------------------------
" No backup
set nobackup
set nowritebackup
set noswapfile

" Keep backup
" set backup
" set directory=$HOME/.vim/swapfiles/,.
" set backupdir=$HOME/.vim/bkupfiles/,.

"----------------------------------------------------------------------
" Moving between Tabs / Windows
"----------------------------------------------------------------------
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<space>
map <leader>t<leader> :tabnext<space>

" Go back to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"----------------------------------------------------------------------
" Vim Configuration End
"----------------------------------------------------------------------





"----------------------------------------------------------------------
" Vim Plugin Configuration Start
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" Vim Plug
"----------------------------------------------------------------------
call plug#begin('~/.vim/bundle')
" Most important -> Save time / error analysis
Plug 'ycm-core/YouCompleteMe'            " auto-completion
Plug 'dense-analysis/ale'                " syntax checking and semantic errors (linter)

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Visual Plugin for vim
Plug 'rose-pine/vim'                     " colorscheme
Plug 'Konfekt/FastFold'                  " fold function

" Various Support tools
Plug 'tpope/vim-fugitive'                " Git support
Plug 'tpope/vim-commentary'              " comment out code easily
Plug 'ntpeters/vim-better-whitespace'    " highlight whitespace

" C++ Specifics
Plug 'bfrg/vim-cpp-modern'               " highlight for cpp
Plug 'vim-scripts/a.vim'                 " goto header / source

call plug#end()

"----------------------------------------------------------------------
" You Complete Me
"----------------------------------------------------------------------
set completeopt-=preview
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm/.ycm_extra_conf.py'

"----------------------------------------------------------------------
" ALE
"----------------------------------------------------------------------
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" Set flags for gcc/clang
let opts = '-std=c++17 -Wall -Wextra -Wshadow -Wconversion -Wpedantic -Werror'
let g:ale_linters = { 'cpp': ['cc', 'gcc', 'clang'] }
let g:ale_cpp_cc_options    = opts
let g:ale_cpp_gcc_options   = opts
let g:ale_cpp_clang_options = opts
" Lint .h files as C++, not C
let g:ale_pattern_options = { '\.h$': { 'ale_linters': { 'cpp' : ['cc', 'gcc', 'clang'] } } }

"----------------------------------------------------------------------
" FZF
"----------------------------------------------------------------------
let g:fzf_action = {
    \ 'ctrl-t': 'tab drop',
    \ }
let g:fzf_buffers_jump = 1  " Jump to the existing window if possible

function! GetGitRoot()
    let top_level = systemlist('git rev-parse --show-toplevel')[0]
    return v:shell_error ? '' : top_level
endfunction

function! ListCurrentFiles()
    let top_level = GetGitRoot()
    if empty(top_level)  " this isn't a git repo
        return fzf#vim#files(getcwd())
    else
        return fzf#vim#gitfiles('--recurse-submodules')
    endif
endfunction
noremap <C-P> :call ListCurrentFiles()<cr>

function! ListGGrepFiles(pattern, bang)
    let top_level = GetGitRoot()
    if empty(top_level)
        return fzf#vim#grep('fgrep -r --line-number '.a:pattern.' '.getcwd(), 0,
                    \       fzf#vim#with_preview({'dir': getcwd()}), a:bang)
    else
        return fzf#vim#grep('git grep --line-number -- '.a:pattern, 0,
                    \       fzf#vim#with_preview({'dir': top_level}), a:bang)
    endif
endfunction
command! -bang -nargs=* GGrep call ListGGrepFiles(shellescape(<q-args>), <bang>0)
noremap \\ :execute 'GGrep<space>'<cr>

"----------------------------------------------------------------------
" Rose Pine
"----------------------------------------------------------------------
colorscheme rosepine

"----------------------------------------------------------------------
" Fast Fold
"----------------------------------------------------------------------
" Set fold method
autocmd FileType python setlocal foldmethod=indent
autocmd FileType c,cpp  setlocal foldmethod=syntax

" Map space to fold / unfold
nnoremap <space> za
nnoremap <S-space> zA

"----------------------------------------------------------------------
" Commentary
"----------------------------------------------------------------------
autocmd FileType c,cpp setlocal commentstring=//\ %s

"----------------------------------------------------------------------
" Vim Plugin Configuration End
"----------------------------------------------------------------------
