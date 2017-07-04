" ~/.vimrc
"
" author: termNinja [https://github.com/termNinja]
" and the god said let there be utf8
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" We use the mighty space as the leader
let mapleader="\<Space>"

set nocompatible 		" vi is cool but vim is IMPROVED :D

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'https://github.com/vim-scripts/CSApprox'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'w0ng/vim-hybrid'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'flazz/vim-colorschemes' "check-out this on interwebz
Plugin 'derekwyatt/vim-protodef'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

set cursorline

" tab switching
map  <C-Tab>     <Esc>:tabnext<CR>
imap <C-Tab>     <Esc>:tabnext<CR>
map  <S-C-Tab>   <Esc>:tabprev<CR>
imap <S-C-Tab>   <Esc>:tabprev<CR>
map  <S-Right>   <Esc>:tabnext<CR>
imap <S-Right>   <Esc>:tabnext<CR>
map  <S-Left>    <Esc>:tabprev<CR>
imap <S-Left>    <Esc>:tabprev<CR>

set laststatus=2

" Files to be ignored
set wildignore+=*.o,*.obj,build,build-*,.*.swp,.*.swo
set wildignore+=*.pyc,*.class,*.jar,*~
set wildignore+=.git,.svn
set wildignore+=project/target/**,target/**
set wildignore+=GPATH,GRTAGS,GSYMS,GTAGS

syntax on
set t_Co=256 			" oh holiest of all, give me some color!

" indenting, wraps and tabs
set shiftwidth=4
set tabstop=4
set softtabstop=0
set cindent
"set smartindent
"set smarttab
"set expandtab
set noexpandtab
"set autoindent 
set number
set textwidth=120
" set nowrap           " no wrapping for you today

" Smart Haskell tabbing


" hex is what i need
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

" searching
set hlsearch
set incsearch

" comments
set comments=sl:/*,mb:\ *,elx:\ */

set undofile
set backspace=indent,eol,start
set cursorline
set scrolloff=2      " up/down 2 lines when on edge
set wildmenu         " tab completion
set completeopt=menu " completions in menus

" make vim remember last cursor position when editing file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" KEY MAPS
" nmap <F2> :w<CR>
" imap <F2> <ESC>:w<CR>i

" Reload vimrc on LEADER+rc
map <Leader>rc :source ~/.vimrc<CR>

" Turn off  highlighted search
map <Leader>hl :nohlsearch<CR>

" Invoke make on LEADER+m
map <Leader>m :make<CR>

" Let's you switch between header and source files
" Make sure to change source and header extensions depending on language
map <F4> :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>
set pastetoggle=<F2>

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" setting theme
"source ~/.vim/colors/darktango.vim
colorscheme space-vim-dark

