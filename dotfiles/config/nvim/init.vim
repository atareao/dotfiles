set encoding=utf-8
let g:ale_disable_lsp = 1
" -------------- template ---------------
augroup templates
    au!
    let g:template_name = 'Lorenzo Carbonell <a.k.a. atareao>'
    autocmd BufNewFile *.* silent! execute '0r $HOME/.config/nvim/templates/'.expand("<afile>:e").'.tpl'
    autocmd BufNewFile * %s/{{YEAR}}/\=strftime('%Y')/ge
    autocmd BufNewFile * %s/{{NAME}}/\=template_name/ge
    autocmd BufNewFile * %s/{{EVAL\s*\([^}]*\)}}/\=eval(submatch(1))/ge
augroup END
" -------------- personal ---------------
set splitright
set splitbelow
" ---- Color theme -----
" important!!
set termguicolors

" Map leader key to space
let mapleader = ' ' " map leader to Space

" Relative number
set number relativenumber

" Line wrap
set wrap linebreak nolist

" Highlight search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Show column 80
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Show ruler
set ruler

" Spell
setlocal spell spelllang=es
hi SpellBad ctermfg=015 ctermbg=009 cterm=bold

" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:.
set listchars=trail:·,space:·
set list

"Run Python from Vim
autocmd FileType javascript map <buffer> <F5> :w<CR>:exec '!gjs' shellescape(@%, 1)<CR>
autocmd FileType javascript imap <buffer> <F5> <esc>:w<CR>:exec '!gjs' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab

" ---- Imports ----
runtime ./plug.vim
runtime ./maps.vim

" ---- Backup ----
" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup
set backupdir   =$HOME/.config/nvim/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.config/nvim/swap/
set updatecount =100
set undofile
set undodir     =$HOME/.config/nvim/undo/
set viminfo     ='100,n$HOME/.config/nvim/info/viminfo
