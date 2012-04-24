alias ls='ls -G'
alias ll='ls -lh'
alias duc='du --max-depth=1 -h'
alias se='sudo vim'
alias rm='rm -rv'
alias cp='cp -rv'
alias mv='mv -v'
alias mkdir='mkdir -p'
alias vi='vim'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\] '
#PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$(__git_ps1 " (%s)") \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\] '
alias pacman='/usr/bin/powerpill --nomessages'
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
complete -cf sudo
export INTEL_BATCH=1
export SVN_EDITOR='vim -c "new|silent r! svn diff"\
 -c "set syntax=diff buftype=nofile" -c "silent 1|wincmd j"'
alias svnuser='sh ~/scripts/svnuser.sh'
[ -f /etc/bash_completion.d/git ] && . /etc/bash_completion.d/git
export MYSQL_PS1="\h:\_(\U)\_[\d]>"
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PAGER=less
#export LESS="-iMSx4 -FX"
if [ -f /opt/local/etc/profile.d/autojump.sh ]; then
    . /opt/local/etc/profile.d/autojump.sh
fi
alias psg="ps aux | egrep -i --color"
export M2_HOME="/usr/share/maven"
