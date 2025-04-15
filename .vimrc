" Disable VI support
set nocompatible
set mouse=a

" Enable file detection
filetype on
filetype plugin on
filetype indent on

" Syntax Highlighting
syntax on
set laststatus=2

" Color Scheme
colorscheme desert

" Set some settings
set number
set cursorline

" Lines and Spacing
set tabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces
set nowrap " Don't wrap lines

" Wild menu
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Search
set incsearch " highlight characters as you search
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000

