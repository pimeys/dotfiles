gnome-settings-daemon &
xrdb $HOME/.Xresources &
xsetroot -solid "#002B36" &
exec /usr/bin/emacs --daemon &
exec $HOME/.dropbox-dist/dropboxd &
exec xmonad
