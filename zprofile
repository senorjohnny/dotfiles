# ~/.zprofile
## Run some noice graphics mr. X
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi

## Path setup

# Path
typeset -U path
path=(~/.bin ~/.composer/vendor/bin $path[@])

