#!/usr/bin/env zsh
# This PS1 will show which branch you are working out of (if applicable) and if that branch is dirty.

setopt PROMPT_SUBST

# Formatting.
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
NF=$(tput sgr0) #No Formatting.

# Check whether Git repo is dirty.
function is-dirty {
  if [ -z "$(git status 2>/dev/null | grep -o 'nothing to commit')" ]; then
    echo '*'
  fi
}

# Determine which branch you are on.
function git-branch {
  git branch 2>/dev/null | awk -v DIRTY=$(is-dirty) '/^\*/ {print "(" $2 DIRTY ")"}'
}

# Determine if pyenv is in use. 
function pyenv-check {
  if pyenv local >/dev/null 2>&1; then
    local PY_ENV=$(pyenv local)
    echo "(${PY_ENV})"
  fi
}

export PS1="${BOLD}${WHITE}\$(pyenv-check)[${GREEN}%n@%m${WHITE}]:${BLUE}%1~${WHITE} ${RED}\$(git-branch)${WHITE}$ ${NF}"
