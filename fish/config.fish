# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme agnoster

set fish_plugins archlinux bundler jump gem rails tmux ssh rvm

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins bundler z

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish
. $HOME/.config/fish/aliases.fish
. $HOME/.config/fish/functions.fish
. /usr/share/autojump/autojump.fish

# OPAM configuration
. /home/pimeys/.opam/opam-init/init.fish
