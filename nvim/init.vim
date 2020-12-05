set number
set shiftwidth=4
set tabstop=4
set autoindent
set clipboard+=unnamed
set hlsearch
set expandtab
set swapfile
set directory=~/nvim/swap
set cursorline
set cursorcolumn
set nobackup
set noundofile

set list
set listchars=tab:»-,trail:.,eol:↲,extends:»,precedes:«,nbsp:%

set tags=./tags

" keybind
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" autocmd
au BufNewFile *.sh set fileformat=unix

" user command
command! Config edit ~/.config/ngim/init.vim

" terminal config
tnoremap <silent> <ESC> <C-\><C-n>
augroup TerminalStuff
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" filetype conf
autocmd FileType json,javascript,vue setlocal shiftwidth=2 ts=2 expandtab
autocmd FileType yaml,yml setlocal shiftwidth=2 ts=2 expandtab

" --------- vim-plug ---------------
call plug#begin('~/.vim/plugged')

Plug 'cocopon/iceberg.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-dispatch'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-goimports'
Plug 'stsewd/isort.nvim'
Plug 'skywind3000/asyncrun.vim'
Plug 'rust-lang/rust.vim'

call plug#end()

function s:is_plugged(name)
    if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
        return 1
    else
        return 0
    endif
endfunction

" colorscheme
if s:is_plugged('iceberg.vim')
    colorscheme iceberg
endif

" NERDTree
if s:is_plugged('nerdtree')
    noremap <C-n> :NERDTreeFocus<CR>
endif

" rust
if s:is_plugged('rust.vim')
    let g:rustfmt_autosave = 1
endif

" lsp
nmap <C-]> :LspDefinition<CR>

" autocmd
au BufNewFile,BufRead *.sh set fileformat=unix
au BufNewFile,BufRead *.py set fileformat=unix

" user command
command! Config edit ~\AppData\Local\nvim\init.vim
command! GConfig edit ~\AppData\Local\nvim\ginit.vim

tnoremap <silent> <ESC> <C-\><C-n>
augroup TerminalStuff
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

command! PhpFmt !phpcbf %
autocmd BufWritePost *.php PhpFmt
