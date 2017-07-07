# ~/.zshrc
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/uros/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# PATH is bliss
export PATH=$PATH:"~/.bin:/home/uros/.gem/ruby/2.4.0/bin"

# Let's make this shell usable lololo
export APACHE_LOG="/var/log/httpd/error_log"
alias -g ls='ls -hl --color=always'
alias -g lss='ls | grep "^d" && ls | grep -v "^d" | grep -E "^.(r|-)"'
alias -g alog='cat $APACHE_LOG | tail -20'
alias -g ares='(sudo systemctl stop httpd) && (sudo cat /dev/null > $APACHE_LOG) && (sudo systemctl start httpd)'
alias -g pacman='sudo pacman --color always'
alias -g up='sudo pacman -Syyuu'
#alias -g fuck='sudo $($(echo !#))' ## TODO: darn that bash leftovers.
alias -g memtest='sudo memtest'
alias -g doctrine='php doctrine.php'
alias -g x='exit'
alias -g sl='ls'
alias -g car='cat'
alias -g cim='vim'
alias -g netest='ping google.com -c 4'
alias -g cdjunk='cd ~/.junk'
alias -g rmjunk='rm -r ~/.junk/*'
alias -g files='echo "There are total $(ls -l | grep -E "^-.*" | wc -l) files in this folder"'
alias -g folders='echo "There are total $(ls -l | grep -E "^d.*" | wc -l) directories in this folder"'
alias -g killme='sudo killall --user $(whoami)'
alias -g rpwd='pwd | sed -e "s|$HOME|~|g"'
alias -g xreset='xrdb ~/.Xresources'
alias -g file-list="ls -t | awk '/16.*/{print $NF}' | sed ':a;N;$!ba;s/\n/ /g'"
alias -g R='R --quiet'
alias -g vim='nvim'
alias -g mnt='(sudo mount /dev/sdb1 /mnt) && (cd /mnt)'
alias -g umnt='(cd ~) && (sudo umount /mnt)'
alias -g cal='cal -m'
alias -g android-connect='aft-mtp-mount ~/.mnt/android'
alias -g android-disconnect='fusermount -u ~/.mnt/android'
alias -g send='kdeconnect-cli -n lge --share'
alias -g transfer='gist'

# Some vars
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_MESSAGES="C"

# Upload this thing
#transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
#tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

# setup background
$(feh --bg-scale ~/uros/pictures/wallpapers/25331-night4.jpg)

# Keystrokes rate and frequency to 300ms and 30Hz
xset r rate 280 20

# Screen blanking turned off
xset s off

# stty erase "^H"
# 
# # Pokreni tmux pri svakom pokretanju bash-a 
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

# Autocomplete like a bos
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion:*' rehash true

# Use the history the smart way
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# Prompting
PROMPT="[%n: %1~> "

# Beauty
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Dirstack
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

## This reverts the +/- operators.
setopt PUSHD_MINUS

# Smart history with <UP>
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# tmux color-fix
#alias tmux="TERM=screen-256color-bce tmux"

# Fixing HOME/DEL keys
bindkey '^[[3~' delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

