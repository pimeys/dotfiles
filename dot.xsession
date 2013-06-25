gnome-settings-daemon &
xscreensaver -no-splash &
xrdb $HOME/.Xresources &
hsetroot -solid "#002B36" &
xcompmgr &
exec $HOME/.dropbox-dist/dropboxd &
exec xmonad
