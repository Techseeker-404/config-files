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
set relativenumber
set cursorline
"set mouse=a
set noswapfile

set colorcolumn=100
"highlight ColorColumn ctermbg=0 guibg=lightgrey 
highlight normal guibg=none

call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags' 
Plug 'mbbill/undotree'           
Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'
Plug 'ivanov/vim-ipython'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rls'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasiser/vim-code-dark'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'crusoexia/vim-monokai'
Plug 'joshdick/onedark.vim'

call plug#end()
""""""""
""Syntastic Mode
""
let g:syntastic_mode_map = {'mode':'passive','active_filetypes':[],'passive_filetypes': []}
"Airline theme
let g:airline_theme= 'base16_grayscale'
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
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1

colorscheme gruvbox 
let g:gruvbox_contrast_dark = 'hard'
"colorscheme codedark
set termguicolors
set background=dark
"Leader and its mappings
noremap <leader>w :w<CR>
noremap <leader>] <C-w>
noremap <leader>l :Lex<CR>
noremap <leader>bn :bnext<CR>  
noremap <leader>f :set relativenumber<CR>  
noremap <leader>g :set norelativenumber<CR>  
noremap <leader>c :SyntasticToggleMode<CR>
noremap <leader>zx :hi Normal guifg=#44cc44 guibg=NONE ctermbg=NONE<CR>
noremap <leader>zc :hi Normal ctermbg=16 guibg=NONE<CR>
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
"""""" If Kite is installed this could help to operate between completion """"""
""""""""setups""""""
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


" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

""""COC Settings and config""""

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
""""

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
""""

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)
""""
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-clangd',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-python', 
  \ ]
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

""""Documentation scrolling in COC""""
"if has('nvim-0.4.3') || has('patch-8.2.0750')
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 8)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, 8)\<cr>" : "\<Left>"

