gnome-settings-daemon &
xscreensaver -no-splash &
xrdb $HOME/.Xresources &
xsetroot -solid "#002B36" &
exec $HOME/.dropbox-dist/dropboxd &
#exec $HOME/.bin/mopidy &
exec xmonad
