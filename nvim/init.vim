"set runtimepath+=/home/uros/.vim,/home/uros/.vim/after
"set packpath+=/home/uros/.vim
"source /home/uros/.vimrc

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
