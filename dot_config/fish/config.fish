source /usr/share/cachyos-fish-config/cachyos-config.fish

starship init fish | source

alias hx="helix"
alias zed="zeditor"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export EDITOR=helix

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
