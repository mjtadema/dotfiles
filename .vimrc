source /etc/vimrc
set nocp
syntax on
:set background=dark
":set number
:map <F5> :w<CR>:!%:p<CR>
:set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
:set splitright
:set splitbelow
:set winheight=5
:set winminheight=5
:set winwidth=25
:set winminwidth=25
:set autoindent
:set number
" Set the following lines in your ~/.vimrc or the systemwide /etc/vimrc:
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
 
" Also, this installs to /usr/share/vim/vimfiles, which may not be in
" your runtime path (RTP). Be sure to add it too, e.g:
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
