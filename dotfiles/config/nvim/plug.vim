" Auto installation of Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('nvim')
  let g:plug_home = stdpath('data') . '/plugged'
endif
" Plugins
call plug#begin()
" -------------------------------
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'jiangmiao/auto-pairs'
" Rust
" Plug 'vim-test/vim-test'
Plug 'rust-lang/rust.vim'
" Git integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Change cursor in Insert and Replace
Plug 'wincent/terminus'
" Color scheme
Plug 'ayu-theme/ayu-vim'
Plug 'junegunn/limelight.vim'
" NeoVim
if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
endif
" -------------------------------
call plug#end()
" -------------- personal ---------------
nmap 
" Deoplete
let g:deoplete#enable_at_startup = 1
" -------------- Airline ---------------
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '|'
let g:airline_symbols.linenr = '|'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '|'
" -------------- Theme ---------------
" let ayucolor="light"
" let ayucolor="mirage"
let ayucolor="dark"
colorscheme ayu
