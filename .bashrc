# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:/home/$(whoami)/.bin

# Startovanje X
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && (exec startx) && (numlockx &)

# normalised ls
alias ls='ls -l --color=always'

# Folders first listing
alias lss='ls | grep "^d" && ls | grep -v "^d" | grep -E "^.(r|-)"'


PS1='[\u@\h \W]\$ '

# Apache configs
export APACHE_LOG=~/.log/httpd/error_log
alias alog='cat $APACHE_LOG | tail -20'
alias ares='(sudo systemctl stop httpd) && (sudo cat /dev/null > $APACHE_LOG) && (sudo systemctl start httpd)'

# Something useful
alias up='sudo pacman -Syyuu'
alias fuck='sudo $(history -p \!\!)'
alias memtest='sudo memtest'
alias doctrine='php doctrine.php'
alias t='todo.sh'

# cause i'm retarded
alias sl='ls'
alias car='cat'
alias cim='vim'

alias netest='ping google.com -c 4'

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export TERM=xterm

#composer
export PATH=$PATH:~/.composer/vendor/bin

# Transfer files online
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

export LANG=en_US.UTF-8
export LC_MESSAGES="C"
alias cdjunk='cd ~/.junk'

# countung counting...
alias files='echo "There are total $(ls -l | grep -E "^-.*" | wc -l) files in this folder"'
alias folders='echo "There are total $(ls -l | grep -E "^d.*" | wc -l) directories in this folder"'

# die
alias ukill='sudo killall --user $(whoami)'

# setup background
$(feh --bg-scale ~/Pictures/star-trek-bg.png)

