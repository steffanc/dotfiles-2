set nocompatible  " Use Vim settings, rather then Vi settings
filetype off      " Required for Vundle setup

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" General devlopement
Bundle 'steffanc/ack.vim'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set binary
set cursorline cursorcolumn
set expandtab
set formatoptions-=t
set hidden
set hlsearch
set history=1000
set ignorecase
set incsearch
if has('statusline')
    set laststatus=2
endif
set lazyredraw                  " redraw only when we need to.
set nobackup
set nomodeline
set noswapfile
set nowritebackup
set number
set pastetoggle=<F2>            " pastetoggle (sane indentation on pastes)
if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
                                " Selected characters/lines in visual mode
endif
set shiftround
set shiftwidth=4
set shortmess+=r
set showmode
set smartcase
set smartindent
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set tabstop=4
set tags=./.tags;/
set textwidth=120
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
if exists('+undodir')
    set undodir=$HOME/.vim/undodir
    set undofile
endif
set wrap

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

if has('gui_running')
   set vb
   set guioptions-=T
   set guioptions-=r
   set go-=L
   set guifont=Source\ Code\ Pro\ for\ Powerline:h12
endif

" Remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

" Syntax and colours
syntax enable
if $TERM == "xterm-256color"
    set t_Co=256
    colorscheme wombat256mod
else
    colorscheme solarized
endif

" Leader tricks
let mapleader=','
nnoremap <Leader>w :w<cr>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>d :sh<cr>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" breakpoints
nnoremap <Leader>b Oimport ipdb; ipdb.set_trace()<esc>

" Quickly edit/reload the vimrc file
nnoremap <silent> <Leader>ve :vsp $MYVIMRC<CR>
nnoremap <silent> <Leader>vs :source $MYVIMRC<CR>

" Search helpers
map <space> /
map <c-space> ?
"search current selection
:vmap / y/<C-R>"<CR>

" Move between windows easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ctags commands
nnoremap <Leader>st :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <Leader>sv :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <Leader>sh :sp <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <Leader>sr :!ctags -R --c++-kinds=+p --fields=+iaS -f .tags --extra=+q .; cscope -bR;<cr><cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \ exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Remap VIM 0 to first non-blank character
map 0 ^

" PLUGINS

" Ack plugin
" Use Ag (https://github.com/ggreer/the_silver_searcher) instead of ACK if we
" have it if we have it
if executable("ag")
    let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
endif
nnoremap <Leader>ff :Ack! 
nnoremap <Leader>fw #*:AckFromSearch!<CR>
" search selection
vmap <Leader>ff /##*:AckFromSearch!<CR>

" Airline plugin
let g:airline_theme='badwolf'
let g:airline_detect_modified=1
let g:airline_powerline_fonts=1
"let g:airline#extensions#tabline#enabled = 1
let g:airline_section_x = airline#section#create([])
let g:airline_section_y = airline#section#create([])

" Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 1
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|pyc|os|swp|orig|out|bak)$'}
if executable("ag")
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --smart-case'
endif

" Fugitive
nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>ge :Gedit<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gw :Gbrowse<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gl :Glog<cr>

" NERD Tree
nnoremap <Leader>r :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.os$', '\.o$', '\.pyc$','\~$']
