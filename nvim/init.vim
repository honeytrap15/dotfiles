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
nmap <C-p> :Isort<CR>

" autocmd
au BufNewFile *.sh set fileformat=unix

" user command
command! Config edit ~/.config/nvim/init.vim

" terminal config
tnoremap <silent> <ESC> <C-\><C-n>
augroup TerminalStuff
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

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

Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'beanworks/vim-phpfmt'
Plug 'cocopon/iceberg.vim'
Plug 'liuchengxu/vista.vim'
Plug 'mattn/vim-goimports'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'stsewd/isort.nvim'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-dispatch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lambdalisue/gina.vim'


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

" quickrun
if s:is_plugged('vim-quickrun') && s:is_plugged('vimproc.vim')
    let g:quickrun_config = get(g:, 'quickrun_config', {})
    let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }
    noremap <A-r> :QuickRun<CR>
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

let g:phpfmt_standard = 'PSR2'
let g:phpfmt_autosave = 1

" vim outline
let g:symbols_outline = {
    \ "highlight_hovered_item": v:true,
    \ "show_guides": v:true,
    \ "position": 'right',
    \ "auto_preview": v:true,
    \ "keymaps": {
        \ "close": "<Esc>",
        \ "goto_location": "<Cr>",
        \ "focus_location": "o",
        \ "hover_symbol": "<C-space>",
        \ "rename_symbol": "r",
        \ "code_actions": "a",
    \ },
    \ "lsp_blacklist": [],
\ }

" vista
nmap <C-o> :Vista vim_lsp<CR>
let g:vista_sidebar_width = 50
