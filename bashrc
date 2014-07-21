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

