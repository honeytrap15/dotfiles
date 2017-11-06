" color config
syntax on
set t_Co=256
set background=dark

" vim config
set number
set clipboard=unnamed
set fenc=utf-8
set nobackup
set swapfile
set directory=~/nvim/swap
set autoread
set showcmd

" editor config
set cursorline
set smartindent
set showmatch
set laststatus=2
set wildmode=list:longest

" search config
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" coding config
set list listchars=tab:\▸\-,trail:･,eol:↲,extends:»,precedes:«,nbsp:%
set expandtab
set tabstop=2
set shiftwidth=2

" dein config
function s:setup_dein()
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
  if dein#load_state($HOME . '/.config/nvim/dein')
    call dein#begin($HOME . '/.config/nvim/dein')
    let s:toml = '~/.config/nvim/plugins.toml'
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#end()
    call dein#save_state()
  endif
  filetype plugin indent on
  if dein#check_install()
    call dein#install()
  endif
endfunction

" deoplete config
function s:setup_deoplete()
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#auto_complete_delay = 100
  let g:deoplete#auto_complete_start_length = 1
  let g:deoplete#enable_camel_case = 0
  let g:deoplete#enable_ignore_case = 0
  let g:deoplete#enable_refresh_always = 0
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#file#enable_buffer_path = 1
  let g:deoplete#max_list = 10000
  inoremap <expr><tab> pumvisible() ? "\<C-n>" :  neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
endfunction

" startup script
if isdirectory($HOME . '/.config/nvim/dein') == 0
  echohl WarningMsg | echo "Not install dein. Execute setup script" | echohl None
else
  " only installed dein and plugins
  call s:setup_dein()
  call s:setup_deoplete()

  " scheme
  colorscheme lucius

  " NERDTree
  let g:NERDTreeShowBookmarks=1
  autocmd vimenter * NERDTree|normal gg3j
  nnoremap <C-n> :NERDTreeFocus<Enter>

endif

" terminal
tnoremap <silent> <ESC> <C-\><C-n>

