# Custom aliases for Bash
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -p --color=tty'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ll='ls -l'
alias la='ls -A'
alias l='ls -la'
alias dux='dir -1A|xargs -i du -ks {}|sort -rn|head -11|awk "{print \$2}"|xargs -i du -hs {}'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
