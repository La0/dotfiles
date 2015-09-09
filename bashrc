export TERMINAL=xterm

# Custom PS1 prompt
# displaying git branch
source /etc/bash_completion.d/git-prompt
DAGGER=$'\xe2\x9a\x94'
PS1="$DAGGER\[\033[32m\]\u:\w\[\033[0m\]\$(__git_ps1) \$\[\033[0m\] "

# Configure Virtualen wrapper
export WORKON_HOME=~/Envs
export PROJECT_HOME=~/dev
virtualenvwrapper_setup_lazy_completion

# Aliases
alias pony="./manage.py runserver"
alias rr="workon runreport && cd ~/dev/runreport/coach"
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
