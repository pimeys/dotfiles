xscreensaver -no-splash &
xrdb $HOME/.Xresources &
compton -f -I 0.10 -O 0.10 --vsync opengl --backend glx &
emacs --daemon &
hsetroot -center /home/pimeys/Pictures/Teufelsberg-25.jpg
exec xmonad
