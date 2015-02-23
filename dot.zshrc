unset RUBYOPT
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerline"

POWERLINE_HIDE_USER_NAME="true"
POWERLINE_HIDE_HOST_NAME="true"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(pass git bundler zsh-syntax-highlighting)

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

source $ZSH/oh-my-zsh.sh
source $HOME/.bash_aliases

setxkbmap -option apple:badmap

export VIMCLOJURE_SERVER_JAR="$HOME/.jar/vimclojure/server-2.3.0.jar"

export TERM="xterm-256color"

export SCALA_HOME="/usr/local/share/scala"

# Customize to your needs...
export PATH=$PATH:/home/pimeys/.bin/:/opt/java6/jre/bin/:/opt/godi/sbin:/opt/godi/bin:/opt/java/jre/bin:/home/pimeys/.cabal/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$SCALA_HOME/bin
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
export EDITOR='vim'
export VIMRUNTIME=/usr/share/vim/vim74a
[[ -s "/home/pimeys/.rvm/scripts/rvm" ]] && source "/home/pimeys/.rvm/scripts/rvm"

#eval "$(hub alias -s)"

doge

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
