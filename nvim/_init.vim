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

" keybind
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nmap <C-p> :Isort<CR>

" syntax
syntax sync minlines=300

" autocmd
au BufNewFile *.sh set fileformat=unix

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" filetype conf
autocmd FileType json,javascript,vue,typescript setlocal shiftwidth=2 ts=2 expandtab
autocmd FileType yaml,yml setlocal shiftwidth=2 ts=2 expandtab
autocmd FileType python setlocal shiftwidth=4 ts=4 expandtab
autocmd FileType html setlocal shiftwidth=2 ts=2 expandtab
autocmd FileType c setlocal shiftwidth=2 ts=2 expandtab
autocmd FileType cpp setlocal shiftwidth=2 ts=2 expandtab

" python path
let g:python3_host_prog = "/usr/bin/python3"

" --------- vim-plug ---------------
call plug#begin('~/.vim/plugged')

" scheme
Plug 'cocopon/iceberg.vim'

" golang
Plug 'mattn/vim-goimports'

" rust
Plug 'rust-lang/rust.vim'

" filer
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" lsp
Plug 'liuchengxu/vista.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'

" common
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'

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
nmap <C-[> :LspPeekDefinition<CR>
nmap <C-L> :LspDocumentFormatSync<CR>
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')

" php
let g:lsp_settings_filetype_php = 'intelephense'

" pyls-all
let g:lsp_settings = {
\   'pylsp-all': {
\     'workspace_config': {
\       'pylsp': {
\         'configurationSources': ['flake8'],
\         'plugins': {
\           'pycodestyle': {
\              'ignore': ['E501'],
\           },
\         },
\       },
\     },
\   },
\   'typescript-language-server': {
\   }
\}

" autocmd
au BufNewFile,BufRead *.sh set fileformat=unix
au BufNewFile,BufRead *.py set fileformat=unix
au BufNewFile,BufRead *.launch,*.test set filetype=xml tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.tsx set tabstop=2 shiftwidth=2

" vista
nmap <C-o> :Vista vim_lsp<CR>
let g:vista_sidebar_width = 50
