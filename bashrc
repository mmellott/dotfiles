# .bashrc

################################################################################
# colors
################################################################################
# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

################################################################################
# stuff
################################################################################

# source system specific stuff
if [ -f ~/.bash_system ]; then
  . ~/.bash_system
fi

# path
PATH=$PATH:$HOME/tmp_bin

# prompt
export PS1="\n\[$BYellow\][\u@\h] [branch goes here] \w\n$ \[$Color_Off\]"

# aliases
alias gvimt='gvim --remote-tab-silent'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cp='cp -v'
alias mv='mv -v'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -al'
alias la='ls -A'
alias l='ls -C'
alias gits='git status'

################################################################################
# tar command helpers
# tgz-* tbz-* txz-*
################################################################################
alias tgz-compress='tar -czvf'
alias tgz-uncompress='tar -xzvf'
alias tgz-test='tar -tzf' # show contents of file

alias tbz-compress='tar -cjvf'
alias tbz-uncompress='tar -xjvf'
alias tbz-test='tar -tjf' # show contents of file

alias txz-compress='tar -cJvf'
alias txz-uncompress='tar -xJvf'
alias txz-test='tar -tJf' # show contents of file

################################################################################
# helper functions
################################################################################
function less {
  vim_less=/usr/share/vim/vim74/macros/less.sh
  if [ -e "$vim_less" ]; then
    $vim_less "$@"
  else
    command less "$@"
  fi
}

function cd {
  command cd "$@" && ls
}

function timer {
  start=`date`
  "$@"
  end=`date`
  echo "Start: $start"
  echo "End: $end"
}

function rm {
  trash_dir="/tmp/trash/$RANDOM"
  mkdir -p "$trash_dir"
  mv "$@" "$trash_dir"
}

################################################################################
# history
################################################################################
export HISTSIZE=50000
export HISTFILESIZE=500000
shopt -s histappend
shopt -s cdspell
export HISTCONTROL=ignoredups:ignorespace
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

