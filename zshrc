unset GREP_OPTIONS

source $HOME/dotfiles/antigen/antigen.zsh
zmodload zsh/zprof
 
antigen-use oh-my-zsh
antigen-bundle git
antigen-bundle vagrant
antigen-bundle zsh-users/zsh-syntax-highlighting
antigen-bundle zsh-users/zsh-history-substring-search
antigen bundle robbyrussell/oh-my-zsh plugins/ruby
antigen bundle robbyrussell/oh-my-zsh plugins/python
antigen bundle pip
antigen bundle sharat87/autoenv
antigen bundle command-not-found
antigen bundle history
antigen bundle vundle
antigen bundle tmux
antigen bundle rupa/z

antigen theme agnoster
 
antigen-apply

export EDITOR="vim"
export BROWSER="luakit"
export SHELL="zsh"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/core_perl"

alias desktop="~/.screenlayout/three.sh"
alias notdesktop="~/.screenlayout/one.sh"
alias tv="~/.screenlayout/tv.sh"

alias java="java -classpath ~/.path/java/junit.jar"
alias javac="javac -classpath ~/.path/java/junit.jar"

alias sduo="sudo"

export PATH=$PATH:/home/max/bin:/home/max/scripts
export PATH=$PATH:/home/max/.gem/ruby/2.1.0/bin
export ECLIPSE_HOME=/lib/eclipse

if [ -f ~/.tmuxinator.zsh ]; then
    source ~/.tmuxinator.zsh
fi

#Stop xon/xoff with ctrl s
stty -ixon
stty stop undef

alias mosh="SHELL=/bin/bash mosh"
alias saltman="mosh root@104.236.4.207"

if [ -f ~/Dev/work/Conversant/scram/shellrc.sh ]; then
    . ~/Dev/work/Conversant/scram/shellrc.sh
fi

mkdircd = function(){
    mkdir $1
    cd $1
}

alias ack='ACK_PAGER_COLOR="less -x4SRFX" /usr/bin/ack'

#Colours in watch
alias watch="watch --color"

alias smount="sudo mount -o umask=0000"

archey3
#zprof
