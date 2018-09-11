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
set ambiwidth=double
inoremap <C-a> <Esc>gg v <S-g> $
inoremap jj <Esc>
noremap <C-k> :cn<CR><Esc>

" ctags
set tags=tags

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

" tab config
map <C-t> :tabnew<Return>
map <C-q> :tabclose<Return>
map <C-h> :tabprevious<Return>
map <C-l> :tabnext<Return>

" filetype
au BufNewFile,BufRead *.pu setf plantuml

" dein config
function s:setup_dein()
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
  if dein#load_state($HOME . '/.config/nvim/dein')
    call dein#begin($HOME . '/.config/nvim/dein')
    call dein#load_toml('~/.config/nvim/plugins.toml', {'lazy': 0})
    call dein#load_toml('~/.config/nvim/lazy.toml', {'lazy': 1})
    call dein#end()
    call dein#save_state()
  endif
  filetype plugin indent on
  if dein#check_install()
    call dein#install()
  endif
endfunction

" startup script
if isdirectory($HOME . '/.config/nvim/dein') == 0
  echohl WarningMsg | echo "Not install dein. Execute setup script" | echohl None
else
  " only installed dein and plugins
  call s:setup_dein()

  " scheme
  colorscheme lucario

  " NERDTree
  let g:NERDTreeShowBookmarks=1
  autocmd vimenter * NERDTree|normal gg3j
  nnoremap <C-n> :NERDTreeFocus<Enter>
  nnoremap <C-c> :NERDTreeToggle<Enter>

  " Template
  augroup MyAutoCmd
    autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
    function! s:template_keywords()
      silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
      silent! %s/<+FILENAME+>/\=expand('%:r')/g
      silent! %s/<+FILENAME_UPPER+>/\=toupper(expand('%:r'))/g
    endfunction
    autocmd MyAutoCmd User plugin-template-loaded
          \   if search('<+CURSOR+>')
          \ |   silent! execute 'normal! "_da>'
          \ | endif
  augroup END

  " Seiya vim
  let g:seiya_auto_enable=1

  " airline
  set laststatus=2
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#whitespace#mixed_indent_algo = 1
  let g:airline_theme = 'vice'

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " powerline symbols
  let g:airline_symbols.branch = ''
  " nim
  let g:nvim_nim_highlighter_semantics=1

  " vim-clang
  let g:clang_c_options = '
        \ -std=c99
        \ -Iinclude
        \'
  let g:clang_cpp_options = '
        \-std=c++11
        \ -Iinclude
        \'
  let g:clang_format#code_style = 'google'
  "autocmd BufWritePre *.cpp,*.hpp,*.c,*.h ClangFormat

  " golang
  let g:go_fmt_command = "goimports"

  " python
  let g:syntastic_python_pep8_args = '--ignore=E501'
  let g:syntastic_python_flake8_args = '--ignore=E501'
  let g:syntastic_python_checkers = ['pep8', 'flake8']
  let g:vim_isort_map = '<C-i>'
  let g:vim_isort_python_version = 'python3'

  function! Autopep8()
      call Preserve(':silent %!autopep8 -')
  endfunction

  " Shift + F で自動修正
  autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>

endif

" terminal
tnoremap <silent> <ESC> <C-\><C-n>
