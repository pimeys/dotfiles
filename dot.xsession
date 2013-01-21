gnome-settings-daemon &
xrdb $HOME/.Xresources &
xsetroot -solid "#002B36" &
exec $HOME/.dropbox-dist/dropboxd &
xmodmap -e "keycode 35 = Pointer_Button2"
xkbset m
exec xmonad
