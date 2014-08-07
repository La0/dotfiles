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
alias rr="workon runreport && cd ~/dev/coach"
alias calepin="workon calepin && cd ~/dev/calepin"

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
