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
"highlight ColorColumn ctermbg=0 guibg=lightgrey 
highlight normal guibg=none

call plug#begin('~/.config/nvim/plugged')

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
"Plug 'vim-syntastic/syntastic'
Plug 'ivanov/vim-ipython'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rls'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
call plug#end()

"kite Intelligent Auto-completion
" All the languages Kite supports
let g:kite_supported_languages = ['*']
"tab key completion
let g:kite_tab_complete=1
"for auto complete
"set completeopt+=noselect
"Airline theme
let g:airline_theme='minimalist'
let g:airline_solarized_bg='dark'
"To set powerline fonts of airline 
let g:airline_powerline_fonts = 1
"To show talines of airline theme buffer
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_y = '%{strftime("%c")}'
let g:airline#extensions#tabline#formatter = 'default'
"""
"Rust Lang
set hidden
let g:racer_cmd = "/home/user/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
"""
colorscheme gruvbox
set background=dark
"Leader and its mappings
noremap <leader>w :w<CR>
noremap <leader>] <C-w>
noremap <leader>l :Lex<CR>
noremap <leader>c :SyntasticToggleMode<CR>
noremap <leader>zx :hi Normal guifg=#44cc44 guibg=NONE ctermbg=NONE<CR>
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

function! s:disable_completion_plugins()
  " coc.nvim
  if exists('g:did_coc_loaded')
    if !exists('b:coc_suggest_disable') || !b:coc_suggest_disable
      let b:coc_suggest_disable = 1
      " Alternatively:
      " autocmd BufEnter *.python :CocDisable
      " autocmd BufLeave *.python :CocEnable
      call kite#utils#warn("disabling coc.nvim's completions in this buffer")
    endif
  endif
  " YouCompleteMe
  if exists('g:loaded_youcompleteme')
    if !exists('g:ycm_filetype_blacklist.python') || !g:ycm_filetype_blacklist.python
      let g:ycm_filetype_blacklist.python = 1
      call kite#utils#warn("disabling YouCompleteMe's completions for python files")
    endif
  endif
endfunction

"Braces auto completion."
inoremap {<CR> {<CR>}<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap { {}<ESC>ha
inoremap ( ()<ESC>ha
inoremap [ []<ESC>ha
let s:pairs={
            \'<': '>',
            \'{': '}',
            \'[': ']',
            \'(': ')',
            \'«': '»',
            \'„': '“',
            \'“': '”',
            \'‘': '’',
        \}
call map(copy(s:pairs), 'extend(s:pairs, {v:val : v:key}, "keep")')
function! InsertPair(left, ...)
    let rlist=reverse(map(split(a:left, '\zs'), 'get(s:pairs, v:val, v:val)'))
    let opts=get(a:000, 0, {})
    let start   = get(opts, 'start',   '')
    let lmiddle = get(opts, 'lmiddle', '')
    let rmiddle = get(opts, 'rmiddle', '')
    let end     = get(opts, 'end',     '')
    let prefix  = get(opts, 'prefix',  '')
    let start.=prefix
    let rmiddle.=prefix
    let left=start.a:left.lmiddle
    let right=rmiddle.join(rlist, '').end
    let moves=repeat("\<Left>", len(split(right, '\zs')))
    return left.right.moves
endfunction
 noremap! <expr> ,f   InsertPair('{')
 noremap! <expr> ,h   InsertPair('[')
 noremap! <expr> ,s   InsertPair('(')
 noremap! <expr> ,u   InsertPair('<')

