# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

function _get_svn_branch {
    svn info 2>/dev/null | grep '^URL:' | egrep -o '(tags|branches|sandbox)/[^/]+|trunk' | egrep -o '[^/]+$'
}

function _get_git_branch {
    git branch 2>/dev/null | grep -e ^* | cut -d\  -f2-
}

function _get_scm_branch {
    local name=$(_get_svn_branch)
    if [ -z $name ]; then
        name=$(_get_git_branch)
    fi
    if [ ! -z "$name" ]; then
        printf " (%s)" "$name"
    fi
}

# Make available for sub-shells...
export -f _get_scm_branch

function color_my_prompt {
    local rst="\[\033[0m\]"
    local user_color="1;34m"
    local host_color="1;32m"
    if [ -w /bin ]; then
        user_color="1;31m"
        host_color="1;31m"
    fi
    local user="\[\033[${user_color}\]\u"
    local host="\[\033[${host_color}\]\h"
    local cwd="\[\033[2;36m\]\w"
    local git_branch="\[\033[1;33m\]"
    PS1="[${user}${rst}@${host}${rst}:${cwd}${git_branch}\$(_get_scm_branch)${rst}]\$ "
}

# Enable a colorful prompt...
color_my_prompt

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
