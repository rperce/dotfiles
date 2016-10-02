#
# ~/.bashrc
#
DOT_PATH_FILE='/home/robert/path/setpath'
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in history
HISTCONTROL=$HISTCONTROL${HISTCONTROL+..}ignoredups
shopt -s histappend

# Boring Prompt
#PS1='[\u@\h \W]\$ '

# Pretty Prompt
#PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Two-line Prompt
line='\[\033[1;32m\]'
if [[ $EUID -eq 0 ]]; then
    line='\[\033[1;31m\]'
fi
blue='\[\033[1;34m\]'
dblue='\[\033[0;34m\]'
white='\[\033[0;37m\]'
cyan='\[\033[1;36m\]'
PS1=$line'╔═('$blue'\u@\h'$line')════['$white'\!'$line']════('$cyan'\w'$line')\n'$line'╚══╡\$\[\033[00m\] '
PS2=$line'╚╡\[\033[00m\] '

# useful ls
alias ls='ls -F --color=auto'
alias la='ls -a'
alias ll='ls -alh'
alias lx='ls -lXB'

# safety
alias rm='rm -i'

# include .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f $DOT_PATH_FILE ]; then
    . $DOT_PATH_FILE
fi
# shh, termite. The world is not ready for you.
if [ "$TERM" = "xterm-termite" ]; then
    export TERM='xterm'
fi

# set colors if in a framebuffer terminal to those of .Xresources
if [ "$TERM" = "linux" ]; then
    colors=(\#222222 \#9e5641 \#6c9e55 \#caaf2b \#7fb8d8 \#956d9d \#4c8ea1 \#808080
            \#454545 \#cc896d \#64e070 \#ffe080 \#b8ddea \#c18fcb \#44c0ff \#cdcdcd)
    for n in $(seq 0 15); do
        printf '\e]P%x%s' $n $(echo "${colors[$n]}" | tr -d \#)
    done
    clear; unset colors
fi

bind 'set mark-symlinked-directories=on'
export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk/'

# git branch tab completion
test -f ~/.git-completion.bash && . $_
test -f /usr/share/fzf/key-bindings.bash && . $_
test -f /usr/share/fzf/completion.bash && . $_

export HISTCONTROL='ignoreboth'
export HISTIGNORE='ls:cd:q'

[ -n "$XTERM_VERSION" ] && transset-df -a > /dev/null

export FZF_DEFAULT_COMMAND='rg --files'

GPG_TTY=$(tty); export GPG_TTY;
PATH="/home/robert/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/robert/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/robert/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/robert/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/robert/perl5"; export PERL_MM_OPT;
