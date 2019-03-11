# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Custom PS1 prompt
# displaying git branch
source /etc/bash_completion.d/git-prompt
#PS1="\[\033[32m\]\u@\h:\w\[\033[0m\]\$(__git_ps1) \$\[\033[0m\] "
export PS1="\[\033[38;5;39m\]\u\[$(tput sgr0)\]\[\033[38;5;8m\]@\[$(tput sgr0)\]\[\033[38;5;39m\]\h\[$(tput sgr0)\]\[\033[38;5;8m\]:\[$(tput sgr0)\]\[\033[38;5;34m\]\w\[\033[38;5;222m\]\$(__git_ps1) \[$(tput sgr0)\]"

# Configure Virtualen wrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export WORKON_HOME=~/Envs
export PROJECT_HOME=~/dev
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
#virtualenvwrapper_setup_lazy_completion

# Aliases
alias pony="./manage.py runserver"
alias rr="workon runreport && cd ~/dev/runreport/app/src"
alias calepin="workon calepin && cd ~/dev/calepin"
alias corpo="workon corporate && cd ~/dev/corporate"
alias p4m="workon p4m && cd ~/dev/playlist4me"

# FFS
export GIT_EDITOR="vim"

# Auto start an ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
  for key in $(ls ~/.ssh/*.key) ;
  do
    /usr/bin/ssh-add $key;
  done
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# Used by OpenEDX vagrant image
export VAGRANT_USE_VBOXFS=true

# Svn Helpers
svndiff() {
  svn diff "${@}" | colordiff
} 

# For vim-gnupg
GPG_TTY=`tty`
export GPG_TTY 

# No cows in ansible !
export ANSIBLE_NOCOWS=1

# Nix OS
if [[ -d ~/.nix-profile ]] ; then
  source ~/.nix-profile/etc/profile.d/nix.sh
fi
