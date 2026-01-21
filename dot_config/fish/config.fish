source /usr/share/cachyos-fish-config/cachyos-config.fish

starship init fish | source

alias hx="helix"
alias zed="zeditor"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export EDITOR=helix

function sudo --description 'alias sudo=run0'
    run0 --background="" $argv
end

eval "$(direnv hook fish)"

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
