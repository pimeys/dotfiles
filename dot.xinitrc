xrandr --output VGA1 --left-of HDMI1 &
xsetroot -solid "#002B36" &
xsetroot -cursor_name left_ptr &
start-pulseaudio-x11 &
xscreensaver -no-splash &
#/usr/lib/gnome-settings-daemon/gnome-settings-daemon &
xrdb $HOME/.Xresources &
setxkbmap -option apple:badmap &
setxkbmap -option caps:escape
xmodmap $HOME/.Xmodmap &
~/.dropbox-dist/dropboxd &
exec xmonad
