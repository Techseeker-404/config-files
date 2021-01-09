" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible


" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
let g:netrw_banner = 0
let g:netrw_winsize = 25
syntax on 
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number

set colorcolumn=100
highlight ColorColumn ctermbg=0 guibg=lightgrey 
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
"Plug 'Valloric/YouCompleteMe'    "As we are using Kite Autocompletion these two
Plug 'mbbill/undotree'           "not any longer needed
"Plug 'vim-scripts/AutoComplPop'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
call plug#end()
"kite Intelligent Auto-completion
" All the languages Kite supports
let g:kite_supported_languages = ['*']
"tab key completion
let g:kite_tab_complete=1
"for auto complete
"set completeopt+=noselect
"Airline theme
let g:airline_theme='tomorrow'
let g:airline_solarized_bg='dark'
"To set powerline fonts of airline 
let g:airline_powerline_fonts = 1
"To show talines of airline theme buffer
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_y = '%{strftime("%c")}'
let g:airline#extensions#tabline#formatter = 'default'
"""
colorscheme gruvbox
set background=dark
"Leader and its mappings
noremap <leader>w :w<CR>
noremap <leader>] <C-w>
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

