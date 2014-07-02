#
# ~/.bashrc
#

DOT_PATH_FILE='/home/robert/.path'
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
first=''
line='\[\033[0;32m\]'
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

# include each line of .path to path
if [ -f "$DOT_PATH_FILE" ]; then
	export PATH=$PATH:`awk '/^[^#]/{printf "%s",(++x!=1?":":"")$0}' $DOT_PATH_FILE`
fi

bind 'set mark-symlinked-directories=on'
export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/vim'


