#!/bin/zsh
# vim: set filetype=zsh

ZDOTDIR=~/.zsh

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# git-prompt
source $ZDOTDIR/plugins/zsh-git-prompt/zshrc.sh

# Fish-like term highlighing
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# ssh-agent
source $ZDOTDIR/plugins/ssh-agent/ssh-agent.plugin.zsh
zstyle :omz:plugins:ssh-agent agent-forwarding on


export BC_ENV_ARGS="--quiet --mathlib"

platform='unknown'
unamestr=`uname`

if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
fi

export HISTTIMEFORMAT="%t%d.%m.%y %H:%M:%S%t"
export HISTIGNORE="&:ls:[bf]g:exit"

export EDITOR="/usr/bin/vim"
export PAGER='less'
export VISUAL='vim'

# I prefer english language
export LANG="en_US.UTF-8"
export LC_PAPER="pl_PL.UTF-8"
export LC_MEASUREMENT="pl_PL.UTF-8"
export LC_TIME="pl_PL.UTF-8" 
export LC_ALL="en_US.UTF-8"

########################################################################################
## Grep colors
# source https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/grep.zsh
grep-flag-available() {
    echo | grep $1 "" >/dev/null 2>&1
}

GREP_OPTIONS=""

# color grep results
if grep-flag-available --color=auto; then
    GREP_OPTIONS+=" --color=auto"
fi

# ignore VCS folders (if the necessary grep flags are available)
VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"

if grep-flag-available --exclude-dir=.cvs; then
    GREP_OPTIONS+=" --exclude-dir=$VCS_FOLDERS"
elif grep-flag-available --exclude=.cvs; then
    GREP_OPTIONS+=" --exclude=$VCS_FOLDERS"
fi

# export grep settings
alias grep="grep $GREP_OPTIONS"
# clean up
unset GREP_OPTIONS
unset VCS_FOLDERS
unfunction grep-flag-available
########################################################################################


# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Avoid "beep"ing
#setopt beep
setopt nobeep

# Extended "globbing"
setopt extended_glob

# try to avoid the 'zsh: no matches found...'
#setopt nomatch
setopt nonomatch

# report the status of backgrounds jobs immediately
setopt notify

#
setopt correctall

#
setopt noflowcontrol

# Send *not* a HUP signal to running jobs when the shell exits.
setopt nohup

# Report the status of background and suspended jobs before exiting a shell
# with job control; a second attempt to exit the shell will succeed.
setopt checkjobs

# change to directory without "cd"
setopt autocd

# display PID when suspending processes as well
setopt longlistjobs

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword


setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
setopt hist_ignore_all_dups # Remove all duplicates from history
setopt hist_reduce_blanks



# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath
