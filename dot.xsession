xscreensaver -no-splash &
xrdb $HOME/.Xresources &
setxkbmap -option caps:escape &
#compton -f -I 0.10 -O 0.10 --vsync opengl --backend glx &
emacs --daemon &
hsetroot -center /home/pimeys/Pictures/brooklyn_bridge.jpg
exec xmonad
