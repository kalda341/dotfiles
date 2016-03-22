set CONF_DIR (dirname (readlink -f (status -f)))

# Path to Oh My Fish install.
set -gx OMF_PATH $CONF_DIR/omf

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

export EDITOR="vim"
export BROWSER="luakit"

eval (thefuck --alias | tr '\n' ';')

alias others='printf "\33]50;%s%d\007" "xft:Source\ Code\ Pro\ Medium:pixelsize=2"'

# Colours in watch
alias watch="watch --color"

alias smount="sudo mount -o umask=0000"

# Source local config if it exists
. $CONF_DIR/config.local

# Greeting
archey3
